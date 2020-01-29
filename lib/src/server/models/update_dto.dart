import 'package:json_annotation/json_annotation.dart';

part 'update_dto.g.dart';

@JsonSerializable(nullable: true)
class UpdateDto {
  UpdateDto();
  factory UpdateDto.fromJson(Map<String, dynamic> json) {
    return _$UpdateDtoFromJson(json);
  }

  int modified;

  Map<String, dynamic> toJson() => _$UpdateDtoToJson(this);
}