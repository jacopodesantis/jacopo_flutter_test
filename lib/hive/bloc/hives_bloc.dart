import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jacopo_flutter_test/hive/model/hive.dart';
import 'package:jacopo_flutter_test/hive/request/hives_get_request.dart';
import 'package:jacopo_flutter_test/hive/service/hives_service.dart';

part 'hives_event.dart';
part 'hives_state.dart';

class HivesBloc extends Bloc<HivesEvent, HivesState> {
  final HivesService service;
  List<Hive> hives = [];
  HivesBloc(this.service) : super(HivesInitial()) {
    on<FetchHives>((event, emit) async {
      if (!event.isLoadMore) {
        emit(HivesLoading());
      }

      try {
        final maybeHives =
            await service.fetchHives(HivesGetRequest(apiaryId: event.apiaryId));
        if (!maybeHives.hasFailed && maybeHives.value != null) {
          List<Hive> loadedHives =
              maybeHives.value!.hives.map((e) => Hive.fromDTO(e)).toList();
          if (event.isLoadMore) {
            hives = [...hives, ...loadedHives];
          } else {
            hives = [...loadedHives];
          }
          emit(
            HivesLoaded(
              hives: hives,
            ),
          );
        }
      } catch (e) {
        emit(const HivesError(errorMessage: 'Failed to load'));
      }
    });
  }
}
