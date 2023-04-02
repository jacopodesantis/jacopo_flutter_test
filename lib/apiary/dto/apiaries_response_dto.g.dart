// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apiaries_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiariesResponseDTO _$ApiariesResponseDTOFromJson(Map<String, dynamic> json) =>
    ApiariesResponseDTO(
      count: json['count'] as int,
      apiaries: (json['results'] as List<dynamic>)
          .map((e) => ApiaryResponseDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      next: json['next'] as String?,
      previous: json['previous'] as String?,
    );

Map<String, dynamic> _$ApiariesResponseDTOToJson(
        ApiariesResponseDTO instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.apiaries,
    };
