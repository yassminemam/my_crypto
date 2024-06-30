import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:my_crypto/core/constants/strings/app_strings.dart';
import '../../../../domain/usecase/get_coin_price/get_coin_price.dart';
import '../../../providers.dart';
import 'home_state.dart';

//init of the homePageStateProvider
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

  //the useCase of getAllCoinsPrices
  final GetCoinPrice _getAllCoinsPrices;

  Future<void> fetchCoinsPrices() async {
    //update the state with loading
    state = state.copyWith(status: HomePageStatus.loading);
    //retrieving the saved userHoldings in Hive db box
    await Hive.openBox(AppStrings.userHoldingsBox).then((userHoldingsBox) async {
      List<String> symbols = [];
      //collecting all the coins symbols of saved userHoldings
      // to fetchCoinsPrices based on them
      for (int x = 0; x < userHoldingsBox.length; x++) {
        symbols.add(userHoldingsBox.getAt(x).symbol ?? "");
      }
      if(symbols.isNotEmpty)
        {
          await _getAllCoinsPrices.call(symbols).then((result) {
            result.fold((l) {
              //in case of failure l means left of Either which is Failure
              state = state.copyWith(
                status: HomePageStatus.failure,
                error: l,
              );
            }, (r) {
              //in case of success r means right of Either which is CoinPriceResponse
              state = state.copyWith(
                status: HomePageStatus.success,
                coinPriceResponse: r,
              );
            });
          });
        }
    });
  }
}
