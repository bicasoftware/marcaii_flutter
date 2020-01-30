import 'package:json_annotation/json_annotation.dart';

part 'refresh_token_result_dto.g.dart';

@JsonSerializable(nullable: true)
class RefreshTokenResultDto {
  RefreshTokenResultDto();

  factory RefreshTokenResultDto.fromJson(Map<String, dynamic> json) {
    return _$RefreshTokenResultDtoFromJson(json);
  }

  String token, refreshToken;

  Map<String, dynamic> toJson() => _$RefreshTokenResultDtoToJson(this);
}
