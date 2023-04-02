part of 'apiaries_bloc.dart';

abstract class ApiariesState extends Equatable {
  const ApiariesState();

  @override
  List<Object> get props => [];
}

class ApiariesInitial extends ApiariesState {}

class ApiariesLoading extends ApiariesState {}

class ApiariesLoaded extends ApiariesState {
  final List<Apiary> apiaries;

  const ApiariesLoaded({required this.apiaries});

  @override
  List<Object> get props => [apiaries];
}

class ApiariesError extends ApiariesState {
  final String errorMessage;

  const ApiariesError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
