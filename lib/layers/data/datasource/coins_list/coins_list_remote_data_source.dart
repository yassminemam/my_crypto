import 'package:dio/dio.dart';
import 'package:my_crypto/core/constants/strings/app_strings.dart';

import '../../../../config/end_poits.dart';
import '../../../../core/error/app_server_error.dart';
import '../../../../core/error/exception.dart';
import '../../model/coins_list/coins_list_response_model.dart';

abstract class CoinsRemoteDataSource {
  Future<CoinsListResponse?> getCoinsList();
}

class CoinsRemoteDataSourceImpl implements CoinsRemoteDataSource {
  final Dio dio;

  CoinsRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<CoinsListResponse?> getCoinsList() async {
    try {
      Map<String, dynamic>? queryParams = {"api_key": AppStrings.apiKey};
      var response =
          await dio.get(EndPoints.getCoinsList, queryParameters: queryParams);
      if (response.statusCode == 200 &&
          response.data["Response"]  == "Success") {
        CoinsListResponse countriesResponseModel =
            CoinsListResponse.fromJson(response.data);
        return countriesResponseModel;
      } else if (response.data["data"] == null &&
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
