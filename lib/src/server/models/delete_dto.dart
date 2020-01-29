import 'package:json_annotation/json_annotation.dart';
part 'delete_dto.g.dart';

@JsonSerializable(nullable: true)
class DeleteDto {
  DeleteDto();
  factory DeleteDto.fromJson(Map<String, dynamic> json) {
    return _$DeleteDtoFromJson(json);
  }

  int removed;

  Map<String, dynamic> toJson() => _$DeleteDtoToJson(this);
}
