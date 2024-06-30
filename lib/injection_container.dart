import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:my_crypto/layers/data/datasource/coin_price/coin_price_remote_data_source.dart';
import 'package:path_provider/path_provider.dart';
import 'config/flavour_config.dart';
import 'core/network/network_info.dart';
import 'core/util/dio_logging_interceptor.dart';
import 'layers/data/datasource/coins_list/coins_list_remote_data_source.dart';
import 'layers/data/model/user_holding/user_holding.dart';

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

  sl.registerLazySingletonAsync<BoxCollection>(() async {
    final directory = await getApplicationDocumentsDirectory();
    final collection = await BoxCollection.open(
      'MyCryptoAppBox',
      {'userHoldings'},
      path: directory.path,
    );
    Hive.registerAdapter(UserHoldingAdapter());
    return collection;
  });
  await sl.isReady<BoxCollection>();

  /**
   * ! Layers
   */
  // Data Source
  sl.registerLazySingleton<CoinsRemoteDataSource>(
      () => CoinsRemoteDataSourceImpl(dio: sl()));

  sl.registerLazySingleton<CoinPriceRemoteDataSource>(
      () => CoinPriceRemoteDataSourceImpl(dio: sl()));
}
