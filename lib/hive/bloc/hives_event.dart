part of 'hives_bloc.dart';

abstract class HivesEvent extends Equatable {
  const HivesEvent();

  @override
  List<Object> get props => [];
}

class FetchHives extends HivesEvent {
  final int apiaryId;
  final bool isLoadMore;

  const FetchHives({
    required this.apiaryId,
    required this.isLoadMore,
  });

  @override
  List<Object> get props => [apiaryId, isLoadMore];
}
