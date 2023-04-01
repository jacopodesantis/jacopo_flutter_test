import 'package:jacopo_flutter_test/core/jacopo_response.dart';
import 'package:jacopo_flutter_test/hive/dto/hive_response_dto.dart';

class HivesResponseDTO extends JacopoResponse {
  final List<HiveResponseDTO> hives;

  const HivesResponseDTO({required this.hives});
}
