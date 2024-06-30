import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_crypto/layers/domain/repo/coins_list/coins_repo.dart';
import 'package:my_crypto/layers/domain/usecase/get_coins_list/get_coins.dart';
import '../../core/network/network_info.dart';
import '../../injection_container.dart';
import '../data/datasource/coins_list/coins_list_remote_data_source.dart';
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

final getAllCoinsProvider = Provider(
  (ref) => GetCoins(
    coinsRepository: ref.read(coinsRepositoryProvider),
  ),
);

// -----------------------------------------------------------------------------
// Data
// -----------------------------------------------------------------------------

final apiProvider = sl<Dio>();

/*final localStorageProvider = Provider<LocalStorage>(
  (ref) => LocalStorageImpl(sharedPreferences: sharedPref),
);*/
