import 'package:dio/dio.dart';
import 'package:jacopo_flutter_test/user/bloc/user_bloc.dart';

class AuthInterceptor extends QueuedInterceptor {
  final UserBloc _userBloc;

  AuthInterceptor(this._userBloc);

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      _userBloc.add(const UserLoggingOut());
    }
    super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    processRequestForAuthToken(options);
    return handler.next(options);
  }

  void processRequestForAuthToken(RequestOptions options) {
    if (options.headers.containsKey('Authorization')) {
      return;
    }

    final userState = _userBloc.state;
    if (userState is UserAuthenticated && _userBloc.token == null) {
      final token = userState.token;

      options.headers.addAll({'Authorization': 'Bearer $token'});
    }
    final token = _userBloc.token;
    if (token != null) {
      options.headers.addAll({'Authorization': 'Bearer $token'});
    }
  }
}
