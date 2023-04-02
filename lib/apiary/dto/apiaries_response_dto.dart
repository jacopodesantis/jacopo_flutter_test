import 'package:jacopo_flutter_test/apiary/dto/apiary_response_dto.dart';
import 'package:jacopo_flutter_test/core/jacopo_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'apiaries_response_dto.g.dart';

@JsonSerializable()
class ApiariesResponseDTO extends JacopoResponse {
  final int count;
  final String? next;
  final String? previous;
  @JsonKey(name: 'results')
  final List<ApiaryResponseDTO> apiaries;

  const ApiariesResponseDTO({
    required this.count,
    required this.apiaries,
    this.next,
    this.previous,
  });

  factory ApiariesResponseDTO.fromJson(Map<String, dynamic> json) {
    return _$ApiariesResponseDTOFromJson(json);
  }
  Map<String, dynamic> toJson() => _$ApiariesResponseDTOToJson(this);
}
