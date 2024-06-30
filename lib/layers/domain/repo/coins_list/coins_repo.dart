import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../data/model/coins_list/coins_list_response_model.dart';

abstract class CoinsRepository {
  Future<Either<Failure, CoinsListResponse?>> getCoinsList();
}