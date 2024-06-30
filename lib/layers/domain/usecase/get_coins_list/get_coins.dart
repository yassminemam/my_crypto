import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../data/model/coins_list/coins_list_response_model.dart';
import '../../repo/coins_list/coins_repo.dart';

//the useCase will return CoinsListResponse? and will call with NoParams
class GetCoins implements UseCase<CoinsListResponse?, NoParams> {
  final CoinsRepository coinsRepository;

  GetCoins({required this.coinsRepository});

  @override
  Future<Either<Failure, CoinsListResponse?>> call(NoParams params) async {
    return await coinsRepository.getCoinsList();
  }
}