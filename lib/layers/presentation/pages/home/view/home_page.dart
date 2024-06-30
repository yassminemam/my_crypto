import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:my_crypto/app_router.dart';
import 'package:my_crypto/core/theme/text_styles.dart';
import '../../../../data/model/user_holding/user_holding.dart';
import '../../add_holding/notifier/add_holding_state_notifier.dart';
import '../notifier/home_notifier.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final List<UserHolding> _allUserHoldings = [];
  bool _lastDeleted = false;

  Future<void> _onRefresh() async {
    final Completer<void> completer = Completer<void>();
    setState(() {
      final userNewHolding =
          ref.read(addHoldingPageStateProvider.notifier).getUserNewHolding();
      if (!_allUserHoldings.contains(userNewHolding) && !_lastDeleted) {
        _allUserHoldings.add(userNewHolding);
      }
    });
    List<String> symbols = [];
    for (var holding in _allUserHoldings) {
      symbols.add(holding.symbol ?? "");
    }
    await ref
        .read(homePageStateProvider.notifier)
        .fetchCoinsPrices(symbols)
        .then((v) {
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
    super.initState();
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
                SizedBox(
                  height: maxHeightConstr - 100.h,
                  child: ListView.builder(
                    itemCount: _allUserHoldings.length,
                    itemBuilder: (context, position) {
                      String symbol =
                          _allUserHoldings[position].symbol ?? "null";
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
                                    _allUserHoldings.removeAt(position);
                                    if (position ==
                                        (_allUserHoldings.length - 1)) {
                                      _lastDeleted = true;
                                    }
                                  }),
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                ),
                                SlidableAction(
                                  onPressed: (c) {},
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  icon: Icons.edit,
                                ),
                              ],
                            ),
                            child: Consumer(
                              builder: (BuildContext context, WidgetRef ref,
                                  Widget? child) {
                                final homeProv =
                                    ref.watch(homePageStateProvider);
                                final coinsPricesMap =
                                    homeProv.coinPriceResponse?.prices ?? {};
                                return Container(
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
                                        "Quantity: ${_allUserHoldings[position].quantity}",
                                        textAlign: TextAlign.start,
                                        style: AppTxtStyles
                                            .size10Weight400TxtStyle
                                            .copyWith(fontSize: 12.sp),
                                      ),
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                      Text(
                                        "Current Price: \$ ${coinsPricesMap[symbol] ?? "null"}",
                                        textAlign: TextAlign.start,
                                        style: AppTxtStyles
                                            .size10Weight400TxtStyle
                                            .copyWith(fontSize: 12.sp),
                                      ),
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                      Text(
                                        "Total: \$ ${(_allUserHoldings[position].quantity! * coinsPricesMap[symbol])}",
                                        textAlign: TextAlign.start,
                                        style: AppTxtStyles
                                            .size10Weight400TxtStyle
                                            .copyWith(fontSize: 12.sp),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ));
                    },
                  ),
                )
              ],
            );
          }),
        )));
  }
}
