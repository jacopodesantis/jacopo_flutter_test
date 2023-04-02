class HiveResponseDTO {
  final int id;
  final int apiaryId;
  final String name;
  final String imageUrl;
  final String externalId;
  final int? imageId;

  const HiveResponseDTO({
    required this.id,
    required this.apiaryId,
    required this.name,
    required this.imageUrl,
    required this.externalId,
    this.imageId,
  });

  factory HiveResponseDTO.fromJson(Map<String, dynamic> json) {
    return HiveResponseDTO(
      id: json['id'],
      apiaryId: json['apiary_id'],
      name: json['name'],
      imageUrl: json['image_url'],
      imageId: json['image_id'],
      externalId: json['external_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'apiary_id': apiaryId,
      'name': name,
      'image_url': imageUrl,
      'image_id': imageId,
      'external_id': externalId,
    };
  }
}
