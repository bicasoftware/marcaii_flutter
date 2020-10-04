import 'dart:convert';

import 'package:intl/intl.dart';

class InsertResult {
  InsertResult({
    this.id,
    this.created_at,
  });

  factory InsertResult.fromMap(Map<String, dynamic> map) {
    if (map == null) {
      return null;
    }

    return InsertResult(
      id: map['id'],
      created_at: DateFormat("yyyy-MM-dd").parse(map['created_at']),
    );
  }

  factory InsertResult.fromJson(Map<String, Object> source) => InsertResult.fromMap(source);

  final int id;
  final DateTime created_at;

  Map<String, dynamic> toMap() {
    return <String, Object>{
      'id': id,
      'created_at': DateFormat("yyyy-MM-dd").format(created_at),
    };
  }

  String toJson() => json.encode(toMap());
}
