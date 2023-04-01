import 'package:dio/dio.dart';
import 'package:jacopo_flutter_test/core/jacopo_request.dart';
import 'package:jacopo_flutter_test/core/jacopo_response.dart';
import 'package:jacopo_flutter_test/error/model/error.dart';

class JacopoApiClient {
  static const baseUrl = 'https://api.3bee.com/api/v1';
  final Dio dio;
  JacopoApiClient({
    required this.dio,
  });

  Future<EitherError<T>> getRequest<T extends JacopoResponse>(
    JacopoRequest request,
    T Function(Map<String, dynamic>) mapper, {
    T Function(Response response)? orElse,
  }) async {
    return _executeRequest(
      () => dio.get(request.endpoint, queryParameters: request.queryParameters),
      mapper,
      orElse: orElse,
    );
  }

  Future<EitherError<T>> postRequest<T extends JacopoResponse>(
    JacopoRequest request,
    T Function(Map<String, dynamic> json) mapper, {
    T Function(Response response)? orElse,
  }) async {
    return _executeRequest(
      () => dio.post(request.endpoint,
          queryParameters: request.queryParameters, data: request.body),
      mapper,
      orElse: orElse,
    );
  }

  Future<EitherError<T>> putRequest<T extends JacopoResponse>(
    JacopoRequest request,
    T Function(Map<String, dynamic>) mapper, {
    T Function(Response response)? orElse,
  }) async {
    return _executeRequest(
      () => dio.put(request.endpoint,
          queryParameters: request.queryParameters, data: request.body),
      mapper,
      orElse: orElse,
    );
  }

  Future<EitherError<T>> deleteRequest<T extends JacopoResponse>(
    JacopoRequest request,
    T Function(Map<String, dynamic>) mapper, {
    T Function(Response)? orElse,
  }) async {
    return _executeRequest(
      () => dio.delete(request.endpoint,
          queryParameters: request.queryParameters),
      mapper,
      orElse: orElse,
    );
  }

  Future<EitherError<T>> _executeRequest<T extends JacopoResponse>(
    Future<Response<dynamic>> Function() dioRequest,
    T Function(Map<String, dynamic>) mapper, {
    T Function(Response response)? orElse,
  }) async {
    try {
      final serverResponse = await dioRequest();
      if (serverResponse.statusCode != null &&
          serverResponse.statusCode! >= 200 &&
          serverResponse.statusCode! < 300) {
        if (serverResponse.data is Map<String, dynamic> &&
            mapper is! SimpleResponse<bool> Function(Map<String, dynamic>)) {
          if (serverResponse.data is List) {
            return EitherError.value(mapper(serverResponse.data));
          }
          return EitherError.value(mapper(serverResponse.data));
        } else {
          if (orElse != null) {
            return EitherError.value(orElse(serverResponse));
          } else {
            return EitherError.error(
                'BE data is not a valid json so you should define orElse method');
          }
        }
      } else if (serverResponse.statusCode == 401) {
        return EitherError.error('Unauthorized');
      } else {
        return EitherError.error(serverResponse.data['message']);
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response != null && e.response!.statusCode == 401) {
          return EitherError.error('Unauthorized');
        } else {
          return EitherError.error(e.toString(), stack: e.response);
        }
      }
      return EitherError.error(e.toString());
    }
  }
}
