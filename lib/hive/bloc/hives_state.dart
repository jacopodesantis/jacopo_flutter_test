part of 'hives_bloc.dart';

abstract class HivesState extends Equatable {
  const HivesState();

  @override
  List<Object> get props => [];
}

class HivesInitial extends HivesState {}

class HivesLoading extends HivesState {}

class HivesLoaded extends HivesState {
  final List<Hive> hives;

  const HivesLoaded({required this.hives});

  @override
  List<Object> get props => [hives];
}

class HivesError extends HivesState {
  final String errorMessage;

  const HivesError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
