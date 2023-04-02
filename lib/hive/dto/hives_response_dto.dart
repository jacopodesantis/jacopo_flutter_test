import 'package:jacopo_flutter_test/core/jacopo_response.dart';
import 'package:jacopo_flutter_test/hive/dto/hive_response_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hives_response_dto.g.dart';

@JsonSerializable()
class HivesResponseDTO extends JacopoResponse {
  final int count;
  final String? next;
  final String? previous;
  @JsonKey(name: 'results')
  final List<HiveResponseDTO> hives;

  const HivesResponseDTO({
    required this.count,
    required this.hives,
    this.next,
    this.previous,
  });

  factory HivesResponseDTO.fromJson(Map<String, dynamic> json) {
    return _$HivesResponseDTOFromJson(json);
  }
  Map<String, dynamic> toJson() => _$HivesResponseDTOToJson(this);
}
