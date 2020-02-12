import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart';

part 'error_dto.g.dart';

@immutable
@JsonSerializable(nullable: true)
class ErroDto {
  const ErroDto(this.field, this.message);

  factory ErroDto.fromJson(Map<String, dynamic> json) {
    return _$ErroDtoFromJson(json);
  }

  final String field, message;

  Map<String, dynamic> toJson() => _$ErroDtoToJson(this);
}
