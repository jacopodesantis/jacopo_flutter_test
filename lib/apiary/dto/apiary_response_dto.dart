class ApiaryResponseDTO {
  final int id;
  final String name;
  final String? color;
  final Map<String, dynamic> weights;

  const ApiaryResponseDTO({
    required this.id,
    required this.name,
    required this.weights,
    this.color,
  });

  factory ApiaryResponseDTO.fromJson(Map<String, dynamic> json) {
    return ApiaryResponseDTO(
      id: json['id'],
      name: json['name'],
      color: json['color'],
      weights: json['weights']['delta'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color,
      'weights': {
        'delta': weights,
      },
    };
  }
}
