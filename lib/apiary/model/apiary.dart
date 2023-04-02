import 'package:flutter/material.dart';
import 'package:jacopo_flutter_test/apiary/dto/apiary_response_dto.dart';

class Apiary {
  final int id;
  final String name;
  final Color color;
  final Map<String, dynamic> weights;

  const Apiary({
    required this.id,
    required this.name,
    required this.color,
    required this.weights,
  });

  factory Apiary.fromDTO(ApiaryResponseDTO dto) {
    return Apiary(
      id: dto.id,
      name: dto.name,
      color: dto.color != null
          ? Color(int.parse(dto.color!.replaceFirst('#', 'ff'), radix: 16))
          : Colors.green,
      weights: dto.weights,
    );
  }
}
