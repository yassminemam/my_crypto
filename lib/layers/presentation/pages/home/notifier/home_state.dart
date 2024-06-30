import 'package:equatable/equatable.dart';
import 'package:my_crypto/layers/data/model/coin_price/coin_price.dart';
import '../../../../../core/error/failure.dart';

enum HomePageStatus { initial, loading, success, failure }

class HomePageState extends Equatable {
  const HomePageState(
      {this.status = HomePageStatus.initial,
        this.coinPriceResponse,
        this.error,
        this.coinsSymbols});

  final HomePageStatus status;
  final CoinPriceResponse? coinPriceResponse;
  final Failure? error;
  final List<String>? coinsSymbols;

  HomePageState copyWith(
      {HomePageStatus? status,
        CoinPriceResponse? coinPriceResponse,
        Failure? error,
        List<String>? coinsSymbols}) {
    return HomePageState(
        status: status ?? this.status,
        error: error ?? ConnectionFailure(),
        coinPriceResponse: coinPriceResponse,
        coinsSymbols: coinsSymbols);
  }

  @override
  List<Object?> get props =>
      [status, coinPriceResponse, error, coinsSymbols];
}