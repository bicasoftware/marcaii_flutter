import 'package:marcaii_flutter/src/database/sqlite_generator/column_types.dart';

mixin SqliteColumnHelper {
  String build();

  String isNullable(bool val) {
    return !val ? "NOT NULL" : "";
  }

  Object _secureEscape(Object value) {
    if (value is String) {
      return """ '$value' """;
    }
    return value;
  }

  String hasDefault(Object defaultValue) {
    return defaultValue != null ? "DEFAULT ${_secureEscape(defaultValue)}" : "";
  }

  String getColumnType(ColumnTypes type) {
    switch (type) {
      case ColumnTypes.PRIMARY_KEY:
        return "INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT";
        break;
      case ColumnTypes.INTEGER:
        return "INTEGER";
        break;
      case ColumnTypes.REAL:
        return "REAL";
        break;
      case ColumnTypes.TEXT:
        return "TEXT";
        break;
      default:
        return "TEXT";
        break;
    }
  }
}
