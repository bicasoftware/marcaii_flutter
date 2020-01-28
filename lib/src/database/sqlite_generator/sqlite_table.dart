import 'package:flutter/foundation.dart';
import 'package:marcaii_flutter/src/database/sqlite_generator/sqlite_column.dart';

class SqliteTable {
  SqliteTable(
    this.tableName, {
    @required this.columns,
  })  : assert(columns.isNotEmpty),
        assert(tableName.isNotEmpty);

  String tableName;
  Map<String, SqliteColumn> columns;

  String generateCreateQuery() {
    var sql = "CREATE TABLE IF NOT EXISTS $tableName(";
    final rows = <String>[];
    columns.forEach((k, v) => rows.add("$k ${v.build()}"));
    sql += rows.join(',');

    return sql += ');';
  }
}
