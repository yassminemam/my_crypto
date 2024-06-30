import 'package:equatable/equatable.dart';
import 'package:my_crypto/layers/data/model/user_holding/user_holding.dart';
import '../../../../../core/error/failure.dart';
import '../../../../data/model/coins_list/coins_list_response_model.dart';

//enum for the most generic states of the AddHolding page provider
enum AddHoldingPageStatus { initial, loading, success, failure }

class AddHoldingPageState extends Equatable {
  const AddHoldingPageState(
      {this.status = AddHoldingPageStatus.initial,
      this.coinsListResponse,
      this.error,
      this.userNewHolding});

  final AddHoldingPageStatus status;
  final CoinsListResponse? coinsListResponse;
  final Failure? error;
  final UserHolding? userNewHolding;
  //to update the state we use the copyWith fun
  AddHoldingPageState copyWith(
      {AddHoldingPageStatus? status,
      CoinsListResponse? coinsListResponse,
      Failure? error,
        UserHolding? userNewHolding}) {
    return AddHoldingPageState(
        status: status ?? this.status,
        error: error ?? ConnectionFailure(),
        coinsListResponse: coinsListResponse,
        userNewHolding: userNewHolding);
  }

  @override
  List<Object?> get props =>
      [status, coinsListResponse, error, userNewHolding];
}
