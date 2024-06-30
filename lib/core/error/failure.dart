import 'package:equatable/equatable.dart';
import '../constants/strings/app_strings.dart';

abstract class Failure extends Equatable {
  final String _errorMessage;

  String get errorMessage => _errorMessage;

  const Failure(this._errorMessage);
}

const String messageConnectionFailure = AppStrings.errorNoInternetConnection;
const String messageCacheFailure = AppStrings.errorCanNotAccessCache;

class AppServerError extends Failure {
  String? response;
  String? message;

  AppServerError(
    this.message, {
    this.response,
  }) : super(message ?? AppStrings.errorUnknownServerError);

  AppServerError.fromJson(Map<String, dynamic> json) : super(json['Message']) {
    response = json['Response'];
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Response'] = response;
    data['Message'] = message;
    return data;
  }

  @override
  List<Object?> get props => [message];

  @override
  String toString() {
    return 'Server Error: $message';
  }
}

class CacheFailure extends Failure {
  CacheFailure() : super(messageCacheFailure);

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'CacheFailure{errorMessage: $messageCacheFailure}';
  }
}

class ConnectionFailure extends Failure {
  ConnectionFailure() : super(messageConnectionFailure);

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'ConnectionFailure{errorMessage: $messageConnectionFailure}';
  }
}
