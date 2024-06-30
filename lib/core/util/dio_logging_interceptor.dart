import 'package:dio/dio.dart';
import 'package:dio/src/dio_mixin.dart';
import '../../config/flavour_config.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (FlavorConfig.instance.flavor == Flavor.DEVELOPMENT) {
      print(
          "--> ${options.method.toUpperCase()} ${"${options.baseUrl}${options.path}"}");
      print('Headers:');
      options.headers.forEach((k, v) => print('$k: $v'));
      print('queryParameters:');
      options.queryParameters.forEach((k, v) => print('$k: $v'));
      if (options.data != null) {
        print('Body: ${options.data}');
      }
      print("--> END ${options.method.toUpperCase()}");
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(response, ResponseInterceptorHandler handler) {
    if (FlavorConfig.instance.flavor == Flavor.DEVELOPMENT) {
      print("<-- ${response.statusCode} ${response.realUri.path}");
      print('Headers:');
      response.headers.forEach((k, v) => print('$k: $v'));
      print('Response: ${response.data}');
      print('<-- END HTTP');
    }
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException dioError, ErrorInterceptorHandler handler) async {
    if (FlavorConfig.instance.flavor == Flavor.DEVELOPMENT) {
      print("<-- ${dioError.message} ${dioError.response?.realUri.path}");
      print(
          "${dioError.response != null ? dioError.response!.data : 'Unknown Error'}");
      print('<-- End error');
    }
    return super.onError(dioError, handler);
  }
}
