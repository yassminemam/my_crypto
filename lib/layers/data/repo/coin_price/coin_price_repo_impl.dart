import 'package:dartz/dartz.dart';
import 'package:my_crypto/layers/data/datasource/coin_price/coin_price_remote_data_source.dart';
import 'package:my_crypto/layers/data/model/coin_price/coin_price.dart';
import 'package:my_crypto/layers/domain/repo/coin_price/coin_price_repo.dart';
import '../../../../core/constants/strings/app_strings.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';

class CoinPriceRepositoryImpl implements CoinPriceRepository {
  final CoinPriceRemoteDataSource coinPriceRemoteDataSource;
  final NetworkInfo networkInfo;

  CoinPriceRepositoryImpl({
    required this.coinPriceRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, CoinPriceResponse?>> getCoinPrice(
      {required List<String> coinSymbol}) async {
    var isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        var response = await coinPriceRemoteDataSource.getCoinPrice(
            coinSymbol: coinSymbol);
        // the response returned from the data souse Either left as Failure
        //Or right as CoinPriceResponse?
        // in case of response was null data from server we return ServerFailure
        return response == null
            ? Left(ServerFailure(AppStrings.errorDataFromServerIsNullError))
            : Right(response);
      } on AppException catch (exp) {
        //catch ServerFailure
        return Left(ServerFailure(exp.errorMessage));
      }
    } else {
      //in case of no connection error
      return Left(ConnectionFailure());
    }
  }
}
