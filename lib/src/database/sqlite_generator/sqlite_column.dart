import 'package:marcaii_flutter/src/database/sqlite_generator/column_types.dart';

import 'sqlite_column_helper.dart';

class SqliteColumn with SqliteColumnHelper {
  SqliteColumn(
    this.columnType, {
    this.nullable = true,
    this.defaultValue,
  });

  bool nullable;
  Object defaultValue;
  ColumnTypes columnType;

  @override
  String build() {
    return "${getColumnType(columnType)} ${isNullable(nullable)} ${hasDefault(defaultValue)}";
  }
}
