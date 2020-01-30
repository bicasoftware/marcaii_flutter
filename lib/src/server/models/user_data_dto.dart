import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_data_dto.g.dart';

@JsonSerializable(nullable: true)
class UserDataDto {
  UserDataDto({
    this.email,
    this.token,
    this.refresh_token,
    this.empregos,
  });

  factory UserDataDto.fromJson(Map<String, dynamic> json) {
    return _$UserDataDtoFromJson(json);
  }

  final String email, token, refresh_token;
  final List<Empregos> empregos;

  Map<String, dynamic> toJson() => _$UserDataDtoToJson(this);
}
