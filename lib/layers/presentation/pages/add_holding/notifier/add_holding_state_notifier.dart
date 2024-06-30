import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:my_crypto/core/usecase/usecase.dart';
import 'package:my_crypto/layers/data/model/user_holding/user_holding.dart';
import '../../../../domain/usecase/get_coins_list/get_coins.dart';
import '../../../providers.dart';
import 'add_holding_state.dart';

final addHoldingPageStateProvider =
    StateNotifierProvider<AddHoldingStateNotifier, AddHoldingPageState>(
  (ref) => AddHoldingStateNotifier(
    getAllCoins: ref.read(getAllCoinsProvider),
  ),
);

class AddHoldingStateNotifier extends StateNotifier<AddHoldingPageState> {
  AddHoldingStateNotifier({
    required GetCoins getAllCoins,
  })  : _getAllCoins = getAllCoins,
        super(const AddHoldingPageState());

  final GetCoins _getAllCoins;

  Future<void> fetchCoinsList() async {
    state = state.copyWith(status: AddHoldingPageStatus.loading);
    await _getAllCoins.call(NoParams()).then((result) {
      result.fold((l) {
        state = state.copyWith(
          status: AddHoldingPageStatus.failure,
          error: l,
        );
      }, (r) {
        state = state.copyWith(
          status: AddHoldingPageStatus.success,
          coinsListResponse: r,
        );
      });
    });
  }

  Future<void> addNewHolding(UserHolding newUserHolding) async {
    state = state.copyWith(
        status: AddHoldingPageStatus.loading,
        coinsListResponse: state.coinsListResponse,
        userNewHolding: state.userNewHolding);
    var box = await Hive.openBox('userHoldings');
    box.add(newUserHolding);
    state = state.copyWith(
        status: AddHoldingPageStatus.success,
        userNewHolding: newUserHolding,
        coinsListResponse: state.coinsListResponse);
  }
}
