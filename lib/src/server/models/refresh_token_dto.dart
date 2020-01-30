import 'package:json_annotation/json_annotation.dart';

part 'refresh_token_dto.g.dart';

@JsonSerializable(nullable: true)
class RefreshTokenDto {
  RefreshTokenDto();

  factory RefreshTokenDto.fromJson(Map<String, dynamic> json) {
    return _$RefreshTokenDtoFromJson(json);
  }

  String refreshToken;

  Map<String, dynamic> toJson() => _$RefreshTokenDtoToJson(this);
}
