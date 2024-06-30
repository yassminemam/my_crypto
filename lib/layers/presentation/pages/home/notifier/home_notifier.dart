import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../../../../injection_container.dart';
import '../../../../domain/usecase/get_coin_price/get_coin_price.dart';
import '../../../providers.dart';
import 'home_state.dart';

final homePageStateProvider =
    StateNotifierProvider<HomeStateNotifier, HomePageState>(
  (ref) => HomeStateNotifier(
    getAllCoinsPrices: ref.read(getAllCoinsPricesProvider),
  ),
);

class HomeStateNotifier extends StateNotifier<HomePageState> {
  HomeStateNotifier({
    required GetCoinPrice getAllCoinsPrices,
  })  : _getAllCoinsPrices = getAllCoinsPrices,
        super(const HomePageState());

  final GetCoinPrice _getAllCoinsPrices;

  Future<void> fetchCoinsPrices() async {
    state = state.copyWith(status: HomePageStatus.loading);
    await Hive.openBox('userHoldings').then((userHoldingsBox) async {
      List<String> symbols = [];
      for (int x = 0; x < userHoldingsBox.length; x++) {
        symbols.add(userHoldingsBox.getAt(x).symbol ?? "");
      }
      await _getAllCoinsPrices.call(symbols).then((result) {
        result.fold((l) {
          state = state.copyWith(
            status: HomePageStatus.failure,
            error: l,
          );
        }, (r) {
          state = state.copyWith(
            status: HomePageStatus.success,
            coinPriceResponse: r,
          );
        });
      });
    });
  }
}
