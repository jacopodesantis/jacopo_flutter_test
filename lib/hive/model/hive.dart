import 'package:jacopo_flutter_test/hive/dto/hive_response_dto.dart';

class Hive {
  final int id;
  final String name;
  final String weight;
  final String image;

  const Hive({
    required this.id,
    required this.name,
    required this.weight,
    required this.image,
  });

  factory Hive.fromDTO(HiveResponseDTO dto) {
    return const Hive(
      id: 1,
      name: 'name',
      weight: 'weight',
      image: 'image',
    );
  }
}
