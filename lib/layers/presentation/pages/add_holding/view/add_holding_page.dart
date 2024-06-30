import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:my_crypto/app_router.dart';
import 'package:my_crypto/core/theme/text_styles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_crypto/layers/data/model/user_holding/user_holding.dart';
import '../../../../../core/constants/strings/app_strings.dart';
import '../../../../../core/util/tools.dart';
import '../../../widgets/button_primary_widget.dart';
import '../../../widgets/input_widget.dart';
import '../notifier/add_holding_state.dart';
import '../notifier/add_holding_state_notifier.dart';

class AddHoldingPage extends ConsumerStatefulWidget {
  const AddHoldingPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddHoldingPageState();
}

class _AddHoldingPageState extends ConsumerState<AddHoldingPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _holdingQuantityCon = TextEditingController();
  final FocusNode _nodeHoldingQuantity = FocusNode();
  UserHolding? _newUserHolding;
  String? _coinSymbol;
  int _selectedCoinPos = -1;

  @override
  void initState() {
    super.initState();
    //calling the addHolding Provider to fetchCoinsList on screen init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(addHoldingPageStateProvider.notifier).fetchCoinsList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          double maxHeightConstr = constraints.maxHeight;
          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SingleChildScrollView(
                child: SizedBox(
                    height: maxHeightConstr,
                    child: Consumer(
                      builder:
                          (BuildContext context, WidgetRef ref, Widget? child) {
                        final addHoldingProv =
                            ref.watch(addHoldingPageStateProvider);
                        final coinsList =
                            addHoldingProv.coinsListResponse?.data?.coins;
                        if (addHoldingProv.status !=
                            AddHoldingPageStatus.success) {
                          if (addHoldingProv.status ==
                              AddHoldingPageStatus.failure) {
                            return Center(
                                child: Text(
                              addHoldingProv.error?.errorMessage ??
                                  AppStrings.errorUnknownError,
                              style: AppTxtStyles.btnTxtStyle
                                  .copyWith(color: Colors.red),
                            ));
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                AppStrings.addNewHoldingHeader,
                                style: AppTxtStyles.mainTxtStyle,
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                AppStrings.chooseYourHolding,
                                style: AppTxtStyles.btnTxtStyle
                                    .copyWith(color: Colors.black),
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              SizedBox(
                                height: 300.h,
                                child: ListView.builder(
                                  itemCount: coinsList?.length,
                                  itemBuilder: (context, position) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          _selectedCoinPos = position;
                                          _coinSymbol =
                                              coinsList?[position].symbol ??
                                                  AppStrings.nullSymbol;
                                        });
                                      },
                                      child: Card(
                                        color: (position == _selectedCoinPos)
                                            ? Colors.blueAccent
                                            : Colors.white,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.0.h),
                                          child: Text(
                                            coinsList?[position].symbol ??
                                                AppStrings.nullSymbol,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 14.0.sp),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                AppStrings.addYourQuantity,
                                style: AppTxtStyles.btnTxtStyle
                                    .copyWith(color: Colors.black),
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              SizedBox(
                                  width: 150.w,
                                  height: 30.h,
                                  child: KeyboardActions(
                                    config: Tools.buildConfig(
                                        context, _nodeHoldingQuantity),
                                    disableScroll: true,
                                    child: InputWidget(
                                      controller: _holdingQuantityCon,
                                      inputType: TextInputType.number,
                                      focusNode: _nodeHoldingQuantity,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      maxLines: 1,
                                      hint: AppStrings.hintRequired,
                                      onChanged: (t) {
                                        _holdingQuantityCon.text = t;
                                      },
                                      onDone: (t) {
                                        _holdingQuantityCon.text = t;
                                      },
                                    ),
                                  )),
                              const Divider(
                                height: 1,
                                color: Colors.blueAccent,
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Expanded(
                                child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: ButtonPrimaryWidget(
                                      AppStrings.addNewHoldingHeader,
                                      height: 40.h,
                                      color: Colors.blueAccent,
                                      onTap: () {
                                        if (_holdingQuantityCon.text.isEmpty ||
                                            _coinSymbol == null) {
                                          Tools.showHintMsg(AppStrings
                                              .pleaseEnterAllTheRequiredData);
                                        } else {
                                          if (double.parse(
                                                  _holdingQuantityCon.text) <=
                                              0) {
                                            Tools.showErrorMessage(AppStrings
                                                .pleaseEnterQuantityGreaterThanZero);
                                          } else {
                                            _newUserHolding = UserHolding(
                                                quantity: double.parse(
                                                    _holdingQuantityCon.text),
                                                symbol: _coinSymbol);
                                            ref
                                                .read(
                                                    addHoldingPageStateProvider
                                                        .notifier)
                                                .addNewHolding(
                                                    _newUserHolding!);
                                            context.pop();
                                            context.go("/$homeRoute");
                                          }
                                        }
                                      },
                                    )),
                              ),
                              SizedBox(
                                height: 200.h,
                              )
                            ],
                          );
                        }
                      },
                    )),
              ));
        })));
  }
}
