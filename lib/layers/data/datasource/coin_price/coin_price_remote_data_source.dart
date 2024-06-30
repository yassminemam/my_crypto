import 'package:dio/dio.dart';
import 'package:my_crypto/core/constants/strings/app_strings.dart';
import '../../../../config/end_poits.dart';
import '../../../../core/error/failure.dart';
import '../../model/coin_price/coin_price.dart';

abstract class CoinPriceRemoteDataSource {
  Future<CoinPriceResponse?> getCoinPrice({required List<String> coinSymbol});
}

class CoinPriceRemoteDataSourceImpl implements CoinPriceRemoteDataSource {
  final Dio dio;

  CoinPriceRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<CoinPriceResponse?> getCoinPrice(
      {required List<String> coinSymbol}) async {
    try {
      Map<String, dynamic>? queryParams = {
        "api_key": AppStrings.apiKey,
        "fsym": "USD",
        "tsyms": coinSymbol
      };
      var response =
          await dio.get(EndPoints.getPrice, queryParameters: queryParams);
      if (response.statusCode == 200) {
        CoinPriceResponse coinPriceResponseModel =
            CoinPriceResponse.fromJson(response.data);
        return coinPriceResponseModel;
      } else if (response.statusCode == 200 && response.data == null) {
        return null;
      } else if (response.statusCode == 200 &&
          response.data["Response"] == "Error") {
        throw AppServerError.fromJson(response.data);
      }
    } on DioException catch (ex) {
      AppServerError? error =
          AppServerError.fromJson(ex.response?.data ?? ex.message);
      throw AppServerError(error.toString());
    }
  }
}
