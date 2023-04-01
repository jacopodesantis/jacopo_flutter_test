// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_login_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLoginResponseDTO _$UserLoginResponseDTOFromJson(
        Map<String, dynamic> json) =>
    UserLoginResponseDTO(
      token: json['access'] as String,
      refresh: json['refresh'] as String,
    );

Map<String, dynamic> _$UserLoginResponseDTOToJson(
        UserLoginResponseDTO instance) =>
    <String, dynamic>{
      'access': instance.token,
      'refresh': instance.refresh,
    };
