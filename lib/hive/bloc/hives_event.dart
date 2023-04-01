part of 'hives_bloc.dart';

abstract class HivesEvent extends Equatable {
  const HivesEvent();

  @override
  List<Object> get props => [];
}

class FetchHives extends HivesEvent {}
