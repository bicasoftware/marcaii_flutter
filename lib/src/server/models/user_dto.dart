import "package:json_annotation/json_annotation.dart";

part 'user_dto.g.dart';

@JsonSerializable(nullable: true)
class UserDto {
  UserDto({
    this.email,
    this.password,
    this.username,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return _$UserDtoFromJson(json);
  }

  final String email, password, username;

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
