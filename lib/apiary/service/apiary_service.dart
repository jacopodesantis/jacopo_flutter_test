import 'package:jacopo_flutter_test/apiary/dto/apiaries_response_dto.dart';
import 'package:jacopo_flutter_test/core/jacopo_api_client.dart';
import 'package:jacopo_flutter_test/core/jacopo_request.dart';
import 'package:jacopo_flutter_test/core/jacopo_service.dart';
import 'package:jacopo_flutter_test/error/model/error.dart';

class ApiariesService extends JacopoService {
  ApiariesService(JacopoApiClient client) : super(client);

  Future<EitherError<ApiariesResponseDTO>> fetchApiaries(
      JacopoRequest request) async {
    final response = await client.getRequest(
        request, (json) => ApiariesResponseDTO.fromJson(json));

    if (!response.hasFailed && response.value != null) {
      return EitherError.value(response.value!);
    }
    return EitherError.error(response.error!.message);
  }
}
