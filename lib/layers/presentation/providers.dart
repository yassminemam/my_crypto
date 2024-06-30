import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_crypto/layers/domain/repo/coin_price/coin_price_repo.dart';
import 'package:my_crypto/layers/domain/repo/coins_list/coins_repo.dart';
import 'package:my_crypto/layers/domain/usecase/get_coin_price/get_coin_price.dart';
import 'package:my_crypto/layers/domain/usecase/get_coins_list/get_coins.dart';
import '../../core/network/network_info.dart';
import '../../injection_container.dart';
import '../data/datasource/coin_price/coin_price_remote_data_source.dart';
import '../data/datasource/coins_list/coins_list_remote_data_source.dart';
import '../data/repo/coin_price/coin_price_repo_impl.dart';
import '../data/repo/coins_list/coins_repo_impl.dart';

// -----------------------------------------------------------------------------
// Presentation
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// Domain
// -----------------------------------------------------------------------------
final coinsRepositoryProvider = Provider<CoinsRepository>(
  (ref) => CoinsRepositoryImpl(
    coinsRemoteDataSource: sl<CoinsRemoteDataSource>(),
    networkInfo: sl<NetworkInfo>(),
  ),
);

final coinPriceRepositoryProvider = Provider<CoinPriceRepository>(
      (ref) => CoinPriceRepositoryImpl(
    coinPriceRemoteDataSource: sl<CoinPriceRemoteDataSource>(),
    networkInfo: sl<NetworkInfo>(),
  ),
);

final getAllCoinsProvider = Provider(
  (ref) => GetCoins(
    coinsRepository: ref.read(coinsRepositoryProvider),
  ),
);

final getAllCoinsPricesProvider = Provider(
      (ref) => GetCoinPrice(
    coinPriceRepository: ref.read(coinPriceRepositoryProvider),
  ),
);

// -----------------------------------------------------------------------------
// Data
// -----------------------------------------------------------------------------

final apiProvider = sl<Dio>();

/*final localStorageProvider = Provider<LocalStorage>(
  (ref) => LocalStorageImpl(sharedPreferences: sharedPref),
);*/
