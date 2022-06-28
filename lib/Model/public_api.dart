// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'public_api.g.dart';


@JsonSerializable()

class Users {
  int page;
  int per_page;
  int total;

Users({required this.page, required this.per_page, required this.total});

  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);

}

