import 'package:dartz/dartz.dart';
import '../../../../core/constants/strings/app_strings.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../../domain/repo/coins_list/coins_repo.dart';
import '../../datasource/coins_list/coins_list_remote_data_source.dart';
import '../../model/coins_list/coins_list_response_model.dart';

class CoinsRepositoryImpl implements CoinsRepository {
  final CoinsRemoteDataSource coinsRemoteDataSource;
  final NetworkInfo networkInfo;

  CoinsRepositoryImpl({
    required this.coinsRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, CoinsListResponse?>> getCoinsList() async {
    var isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        var response =
            await coinsRemoteDataSource.getCoinsList();
        // the response returned from the data souse Either left as Failure
        //Or right as CoinsListResponse?
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
