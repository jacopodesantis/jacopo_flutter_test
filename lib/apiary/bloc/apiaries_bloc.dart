import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jacopo_flutter_test/apiary/model/apiary.dart';
import 'package:jacopo_flutter_test/apiary/request/apiaries_get_request.dart';
import 'package:jacopo_flutter_test/apiary/service/apiary_service.dart';

part 'apiaries_event.dart';
part 'apiaries_state.dart';

class ApiariesBloc extends Bloc<ApiariesEvent, ApiariesState> {
  final ApiariesService service;
  ApiariesBloc(this.service) : super(ApiariesInitial()) {
    on<FetchApiaries>((event, emit) async {
      emit(ApiariesLoading());

      try {
        final maybeApiaries = await service.fetchApiaries(ApiariesGetRequest());
        if (!maybeApiaries.hasFailed && maybeApiaries.value != null) {
          emit(
            ApiariesLoaded(
              apiaries: maybeApiaries.value!.apiaries
                  .map((e) => Apiary.fromDTO(e))
                  .toList(),
            ),
          );
        }
      } catch (e) {
        emit(const ApiariesError(errorMessage: 'Failed to load'));
      }
    });
  }
}
