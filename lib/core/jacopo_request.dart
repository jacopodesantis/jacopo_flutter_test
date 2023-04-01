import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class JacopoRequest extends Equatable {
  String get endpoint;
  final Map<String, dynamic> queryParameters;
  final Map<String, dynamic> body;
  final BaseOptions? additionalOptions;

  const JacopoRequest({
    this.queryParameters = const {},
    this.body = const {},
    this.additionalOptions,
  });

  @override
  List<Object?> get props =>
      [endpoint, queryParameters, body, additionalOptions];
}
