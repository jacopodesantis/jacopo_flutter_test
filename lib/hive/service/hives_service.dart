import 'package:jacopo_flutter_test/core/jacopo_api_client.dart';
import 'package:jacopo_flutter_test/core/jacopo_request.dart';
import 'package:jacopo_flutter_test/core/jacopo_service.dart';
import 'package:jacopo_flutter_test/error/model/error.dart';
import 'package:jacopo_flutter_test/hive/dto/hives_response_dto.dart';

class HivesService extends JacopoService {
  HivesService(JacopoApiClient client) : super(client);

  Future<EitherError<HivesResponseDTO>> fetchHives(
      JacopoRequest request) async {
    final response = await client.getRequest(
        request, (json) => HivesResponseDTO.fromJson(json));

    if (!response.hasFailed && response.value != null) {
      return EitherError.value(response.value!);
    }
    return EitherError.error(response.error!.message);
  }
}
