// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Users _$UsersFromJson(Map<String, dynamic> json) => Users(
      page: json['page'] as int,
      per_page: json['per_page'] as int,
      total: json['total'] as int,
    );

Map<String, dynamic> _$UsersToJson(Users instance) => <String, dynamic>{
      'page': instance.page,
      'per_page': instance.per_page,
      'total': instance.total,
    };
