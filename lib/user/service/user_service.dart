import 'package:jacopo_flutter_test/core/jacopo_api_client.dart';
import 'package:jacopo_flutter_test/core/jacopo_request.dart';
import 'package:jacopo_flutter_test/core/jacopo_service.dart';
import 'package:jacopo_flutter_test/error/model/error.dart';
import 'package:jacopo_flutter_test/user/dto/user_login_response_dto.dart';

class UserService extends JacopoService {
  UserService(JacopoApiClient client) : super(client);

  Future<EitherError<UserLoginResponseDTO>> login(JacopoRequest request) async {
    final response = await client.postRequest(
        request, (json) => UserLoginResponseDTO.fromJson(json));

    if (!response.hasFailed && response.value != null) {
      return EitherError.value(response.value!);
    }
    return EitherError.error(response.error!.message);
  }

  Future<EitherError<UserLoginResponseDTO>> verifyToken(
      JacopoRequest request) async {
    final response = await client.postRequest(
        request, (json) => UserLoginResponseDTO.fromJson(json));

    if (!response.hasFailed && response.value != null) {
      return EitherError.value(response.value!);
    }
    return EitherError.error(response.error!.message);
  }
}
