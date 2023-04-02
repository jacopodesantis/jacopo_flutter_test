// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hives_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HivesResponseDTO _$HivesResponseDTOFromJson(Map<String, dynamic> json) =>
    HivesResponseDTO(
      count: json['count'] as int,
      hives: (json['results'] as List<dynamic>)
          .map((e) => HiveResponseDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      next: json['next'] as String?,
      previous: json['previous'] as String?,
    );

Map<String, dynamic> _$HivesResponseDTOToJson(HivesResponseDTO instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.hives,
    };
