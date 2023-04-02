import 'package:jacopo_flutter_test/hive/dto/hive_response_dto.dart';

class Hive {
  final int id;
  final int apiaryId;
  final String name;
  final String image;
  final String externalId;

  const Hive({
    required this.id,
    required this.apiaryId,
    required this.name,
    required this.image,
    required this.externalId,
  });

  factory Hive.fromDTO(HiveResponseDTO dto) {
    return Hive(
      id: dto.id,
      apiaryId: dto.apiaryId,
      name: dto.name,
      image: dto.imageUrl,
      externalId: dto.externalId.substring(dto.externalId.length - 6),
    );
  }
}
