import 'package:flutter/foundation.dart';

@immutable
class UnregisterDto {
  const UnregisterDto({this.removed});

  factory UnregisterDto.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }

    return UnregisterDto(
      removed: json['removed'],
    );
  }

  final bool removed;

  Map<String, dynamic> toJson() {
    return {'removed': removed};
  }
}
