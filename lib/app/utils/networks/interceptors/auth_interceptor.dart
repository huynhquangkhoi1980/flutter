import 'package:dio/dio.dart';
import 'package:mevn_app/kickoff/local/pref_provider.dart';

class AuthInterceptor extends Interceptor {
  final PrefProvider _prefProvider;

  AuthInterceptor(this._prefProvider);

  @override
  // ignore: avoid_void_async
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!isAuthenticationAlready(options)) {
      final idToken = _prefProvider.idToken;
      if (idToken != null && idToken.isNotEmpty) {
        options.headers['token'] = idToken;
      }
    }
    if (options.method == 'POST') {
      options.data['user_email'] = '${_prefProvider.userEmail}';
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  // ignore: avoid_void_async
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    handler.next(err);
  }

  bool isAuthenticationAlready(RequestOptions options) {
    return options.headers.containsKey('token');
  }
}
