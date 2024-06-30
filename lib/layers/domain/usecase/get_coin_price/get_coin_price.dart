import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../data/model/coin_price/coin_price.dart';
import '../../repo/coin_price/coin_price_repo.dart';

class GetCoinPrice implements UseCase<CoinPriceResponse?, List<String>> {
  final CoinPriceRepository coinPriceRepository;

  GetCoinPrice({required this.coinPriceRepository});

  @override
  Future<Either<Failure, CoinPriceResponse?>> call(List<String> coinSymbol) async {
    return await coinPriceRepository.getCoinPrice(coinSymbol: coinSymbol);
  }
}