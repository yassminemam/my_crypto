import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:my_crypto/layers/domain/usecase/get_coins_list/get_coins.dart';
import 'config/flavour_config.dart';
import 'core/network/network_info.dart';
import 'core/util/dio_logging_interceptor.dart';
import 'layers/data/datasource/coins_list/coins_list_remote_data_source.dart';
import 'layers/data/repo/coins_list/coins_repo_impl.dart';
import 'layers/domain/repo/coins_list/coins_repo.dart';
import 'layers/presentation/pages/add_holding/notifier/add_holding_state_notifier.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /**
   * ! Core
   */
  sl.registerLazySingleton<DataConnectionChecker>(
      () => DataConnectionChecker());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  /**
   * ! External
   */
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio();
    dio.options.baseUrl = FlavorConfig.instance.values.baseUrl;
    Map<String, dynamic> header = {};
    header['Content-Type'] = "application/json";
    header['Accept'] = "application/json";
    header['Accept-Language'] = "ar";
    dio.options.headers = header;
    dio.interceptors.add(LoggingInterceptor());
    return dio;
  });
/*
  sl.registerLazySingletonAsync<SharedPreferences>(() {
    final sharedPref = SharedPreferences.getInstance();
    return sharedPref;
  });
  await sl.isReady<SharedPreferences>();
*/
  /**
   * ! Layers
   */
  // Data Source
  sl.registerLazySingleton<CoinsRemoteDataSource>(
      () => CoinsRemoteDataSourceImpl(dio: sl()));

  // Repository
  sl.registerLazySingleton<CoinsRepository>(() => CoinsRepositoryImpl(
        coinsRemoteDataSource: sl<CoinsRemoteDataSource>(),
        networkInfo: sl<NetworkInfo>(),
      ));

  // Use Case
  sl.registerLazySingleton(() => GetCoins(coinsRepository: sl()));

  // Provider
  sl.registerFactory<AddHoldingStateNotifier>(
    () => AddHoldingStateNotifier(getAllCoins: sl()),
  );
}
