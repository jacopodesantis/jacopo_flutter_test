import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

class ApiariesCounterState extends Equatable {
  final int apiariesNum;
  final int currentApiary;
  final bool areThereOtherApiaries;
  const ApiariesCounterState({
    this.apiariesNum = 0,
    this.currentApiary = 0,
    this.areThereOtherApiaries = false,
  });

  @override
  List<Object?> get props => [
        apiariesNum,
        currentApiary,
        areThereOtherApiaries,
      ];

  ApiariesCounterState copyWith(
      {int? apiariesNum, int? currentApiary, bool? areThereOtherApiaries}) {
    return ApiariesCounterState(
      apiariesNum: apiariesNum ?? this.apiariesNum,
      currentApiary: currentApiary ?? this.currentApiary,
      areThereOtherApiaries:
          areThereOtherApiaries ?? this.areThereOtherApiaries,
    );
  }
}

class ApiaryIsChanging extends ApiariesCounterState {}

class ApiariesCounterCubit extends Cubit<ApiariesCounterState> {
  ApiariesCounterCubit() : super(const ApiariesCounterState());

  void initApiariesCounter({required int apiariesLenght}) {
    if (apiariesLenght > 0) {
      emit(
        state.copyWith(
          apiariesNum: apiariesLenght,
          currentApiary: 0,
          areThereOtherApiaries: (apiariesLenght - 1) > 0,
        ),
      );
    } else {
      emit(
        state.copyWith(
          areThereOtherApiaries: false,
        ),
      );
    }
  }

  void changeApiary(int index) {
    final currentState = state;
    if (index > currentState.currentApiary) {
      emit(ApiaryIsChanging());
    }
    if ((currentState.apiariesNum - 1) > index) {
      emit(
        state.copyWith(
          apiariesNum: currentState.apiariesNum,
          currentApiary: currentState.currentApiary > index
              ? currentState.currentApiary - 1
              : currentState.currentApiary + 1,
          areThereOtherApiaries: (currentState.apiariesNum - 1) > index,
        ),
      );
    } else {
      emit(
        state.copyWith(
          apiariesNum: currentState.apiariesNum,
          currentApiary: index,
          areThereOtherApiaries: false,
        ),
      );
    }
  }
}
