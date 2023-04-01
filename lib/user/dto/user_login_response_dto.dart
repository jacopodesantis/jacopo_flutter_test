import 'package:jacopo_flutter_test/core/jacopo_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_login_response_dto.g.dart';

@JsonSerializable()
class UserLoginResponseDTO extends JacopoResponse {
  @JsonKey(name: 'access')
  String token;
  String refresh;

  UserLoginResponseDTO({
    required this.token,
    required this.refresh,
  });

  factory UserLoginResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$UserLoginResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginResponseDTOToJson(this);
}
