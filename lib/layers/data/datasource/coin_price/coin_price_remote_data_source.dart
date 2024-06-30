import 'package:dio/dio.dart';
import 'package:my_crypto/core/constants/strings/app_strings.dart';

import '../../../../config/end_poits.dart';
import '../../../../core/error/app_server_error.dart';
import '../../../../core/error/exception.dart';
import '../../model/coin_price/coin_price.dart';
import '../../model/coins_list/coins_list_response_model.dart';

abstract class CoinPriceRemoteDataSource {
  Future<CoinPriceResponse?> getCoinPrice({required List<String> coinSymbol});
}

class CoinPriceRemoteDataSourceImpl implements CoinPriceRemoteDataSource {
  final Dio dio;

  CoinPriceRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<CoinPriceResponse?> getCoinPrice({required List<String> coinSymbol}) async {
    try {
      Map<String, dynamic>? queryParams = {"fsym": "USD", "tsyms": coinSymbol};
      var response =
          await dio.get(EndPoints.getPrice, queryParameters: queryParams);
      if (response.statusCode == 200) {
        CoinPriceResponse coinPriceResponseModel =
            CoinPriceResponse.fromJson(response.data);
        return coinPriceResponseModel;
      } else if (response.data == null &&
          response.data["Response"] == "Success") {
        return null;
      } else {
        throw AppServerError.fromJson(response.data);
      }
    } on DioException catch (ex) {
      AppServerError? error =
          AppServerError.fromJson(ex.response?.data ?? ex.message);
      throw AppException(error.toString());
    }
  }
}
