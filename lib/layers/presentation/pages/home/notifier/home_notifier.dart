import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  Future<void> fetchCoinsPrices(List<String> symbols) async {
    state = state.copyWith(status: HomePageStatus.loading);
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
  }

}