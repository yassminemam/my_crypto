import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:my_crypto/app_router.dart';
import 'package:my_crypto/core/theme/text_styles.dart';
import 'package:my_crypto/layers/presentation/pages/home/notifier/home_state.dart';
import '../../../../../core/util/tools.dart';
import '../../../widgets/input_widget.dart';
import '../notifier/home_notifier.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FocusNode _nodeEditHoldingQun = FocusNode();
  final TextEditingController _editHoldingQunCon = TextEditingController();
  Timer? timer;

  Future<void> _onRefresh() async {
    final Completer<void> completer = Completer<void>();
    await ref
        .read(homePageStateProvider.notifier)
        .fetchCoinsPrices()
        .then((value) {
      completer.complete();
    });

    return completer.future.then<void>((_) {
      ScaffoldMessenger.of(_scaffoldKey.currentState!.context).showSnackBar(
        const SnackBar(
          content: Text('Refresh complete'),
        ),
      );
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(homePageStateProvider.notifier).fetchCoinsPrices();
    });
    timer = Timer.periodic(
        const Duration(seconds: 10),
        (Timer t) async =>
            await ref.read(homePageStateProvider.notifier).fetchCoinsPrices());

    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
            child: LiquidPullToRefresh(
          onRefresh: _onRefresh,
          backgroundColor: Colors.blueAccent,
          color: Colors.yellow,
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            double maxHeightConstr = constraints.maxHeight;
            double maxWidthConstr = constraints.maxWidth;
            return Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        "Crypto Portfolio",
                        style: AppTxtStyles.mainTxtStyle,
                      )),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          minimumSize: Size(100.w, 30.h),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                        ),
                        onPressed: () {
                          context.go('/$addHolding');
                        },
                        child: Text(
                          '+ Add New Holding',
                          style:
                              AppTxtStyles.btnTxtStyle.copyWith(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Consumer(builder:
                    (BuildContext context, WidgetRef ref, Widget? child) {
                  final homeProv = ref.watch(homePageStateProvider);
                  final coinsPricesMap =
                      homeProv.coinPriceResponse?.prices ?? {};
                  if (homeProv.status != HomePageStatus.success) {
                    if (homeProv.status == HomePageStatus.failure) {
                      return Center(
                          child: Text(
                        homeProv.error?.errorMessage ?? "Error",
                        style: AppTxtStyles.btnTxtStyle
                            .copyWith(color: Colors.red),
                      ));
                    }
                    return const Center(child: CircularProgressIndicator());
                  }
                  return SizedBox(
                      height: maxHeightConstr - 100.h,
                      child: ValueListenableBuilder(
                        valueListenable: Hive.box('userHoldings').listenable(),
                        builder: (context, allUserHoldingsBox, widget) {
                          return ListView.builder(
                            itemCount: allUserHoldingsBox.length,
                            itemBuilder: (context, position) {
                              String symbol =
                                  allUserHoldingsBox.getAt(position).symbol ??
                                      "null";
                              return SizedBox(
                                  height: 120.h,
                                  width: maxWidthConstr - 40,
                                  child: Slidable(
                                    key: ValueKey(position),
                                    endActionPane: ActionPane(
                                      motion: const ScrollMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (c) => setState(() {
                                            allUserHoldingsBox
                                                .deleteAt(position);
                                          }),
                                          backgroundColor: Colors.red,
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                        ),
                                        SlidableAction(
                                          onPressed: (c) async {
                                            await showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Edit Quantity'),
                                                    content: SizedBox(
                                                        height: 30.h,
                                                        child: KeyboardActions(
                                                          config: Tools.buildConfig(
                                                              context,
                                                              _nodeEditHoldingQun),
                                                          disableScroll: true,
                                                          child: InputWidget(
                                                            controller:
                                                                _editHoldingQunCon,
                                                            inputType:
                                                                TextInputType
                                                                    .number,
                                                            focusNode:
                                                                _nodeEditHoldingQun,
                                                            inputFormatters: <TextInputFormatter>[
                                                              FilteringTextInputFormatter
                                                                  .digitsOnly
                                                            ],
                                                            maxLines: 1,
                                                            hint: "required *",
                                                            onChanged: (t) {
                                                              _editHoldingQunCon
                                                                  .text = t;
                                                            },
                                                            onDone: (t) {
                                                              _editHoldingQunCon
                                                                  .text = t;
                                                            },
                                                          ),
                                                        )),
                                                    actions: [
                                                      TextButton(
                                                        child: const Text(
                                                            'Cancel'),
                                                        onPressed: () {
                                                          _editHoldingQunCon
                                                              .clear();
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                      TextButton(
                                                        child:
                                                            const Text('Done'),
                                                        onPressed: () {
                                                          setState(() {
                                                            allUserHoldingsBox
                                                                    .getAt(position)
                                                                    .quantity =
                                                                double.parse(
                                                                    _editHoldingQunCon
                                                                        .text);
                                                            allUserHoldingsBox
                                                                .getAt(position)
                                                                .save();
                                                          });
                                                          _editHoldingQunCon
                                                              .clear();
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                });
                                          },
                                          backgroundColor: Colors.green,
                                          foregroundColor: Colors.white,
                                          icon: Icons.edit,
                                        ),
                                      ],
                                    ),
                                    child: Container(
                                      height: 120.h,
                                      width: maxWidthConstr.w - 40,
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10.h, horizontal: 10.w),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5.h, horizontal: 5.w),
                                      decoration: BoxDecoration(
                                        color: Colors.black12,
                                        border: Border.all(
                                            color: Colors.black12, width: 2.0),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(
                                                5.0) //                 <--- border radius here
                                            ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            symbol,
                                            textAlign: TextAlign.start,
                                            style: AppTxtStyles.mainTxtStyle
                                                .copyWith(fontSize: 14.sp),
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          Text(
                                            "Quantity: ${allUserHoldingsBox.getAt(position).quantity}",
                                            textAlign: TextAlign.start,
                                            style: AppTxtStyles
                                                .size10Weight400TxtStyle
                                                .copyWith(fontSize: 12.sp),
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          Text(
                                            "Current Price: \$ ${coinsPricesMap[symbol] ?? 0.0}",
                                            textAlign: TextAlign.start,
                                            style: AppTxtStyles
                                                .size10Weight400TxtStyle
                                                .copyWith(fontSize: 12.sp),
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          Text(
                                            "Total: \$ ${((allUserHoldingsBox.getAt(position).quantity) * (coinsPricesMap[symbol] ?? 0.0))}",
                                            textAlign: TextAlign.start,
                                            style: AppTxtStyles
                                                .size10Weight400TxtStyle
                                                .copyWith(fontSize: 12.sp),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ));
                            },
                          );
                        },
                      ));
                })
              ],
            );
          }),
        )));
  }
}
