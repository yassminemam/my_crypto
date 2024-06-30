import 'package:dartz/dartz.dart';
import 'package:my_crypto/layers/data/model/coin_price/coin_price.dart';
import '../../../../core/error/failure.dart';

abstract class CoinPriceRepository {
  Future<Either<Failure, CoinPriceResponse?>> getCoinPrice({required List<String> coinSymbol});
}