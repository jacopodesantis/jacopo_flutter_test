part of 'apiaries_bloc.dart';

abstract class ApiariesEvent extends Equatable {
  const ApiariesEvent();

  @override
  List<Object> get props => [];
}

class FetchApiaries extends ApiariesEvent {}
