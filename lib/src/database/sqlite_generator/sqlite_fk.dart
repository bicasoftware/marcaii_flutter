import 'package:flutter/foundation.dart';
import 'package:marcaii_flutter/src/database/sqlite_generator/constraint_types.dart';

class SqliteFK {
  SqliteFK({
    @required this.referenceTable,
    @required this.slaveColumn,
    @required this.masterColumn,
    @required this.onDelete,
    @required this.onUpdate,
  })  : assert(referenceTable != null),
        assert(slaveColumn != null),
        assert(masterColumn != null),
        assert(onDelete != null),
        assert(onUpdate != null);

  final String referenceTable, slaveColumn, masterColumn;
  final ConstraintTypes onDelete, onUpdate;

  String getConstraint(ConstraintTypes constraint) {
    switch (constraint) {
      case ConstraintTypes.SET_NULL:
        return "SET NULL";
        break;
      case ConstraintTypes.SET_DEFAULT:
        return "SET DEFAULT";
        break;
      case ConstraintTypes.RESTRICT:
        return "RESTRICT";
        break;
      case ConstraintTypes.NO_ACTION:
        return "NO ACTION";
        break;
      case ConstraintTypes.CASCADE:
        return "CASCADE";
        break;
      default:
        return "CASCADE";
    }
  }

  String generateFK() {
    //FOREIGN KEY (foreign_key_columns)
    //REFERENCES parent_table(parent_key_columns)
    //    ON UPDATE action
    //    ON DELETE action;

    return """FOREIGN KEY ($slaveColumn) REFERENCES $referenceTable($masterColumn) ON UPDATE ${getConstraint(onUpdate)} ON DELETE ${getConstraint(onDelete)}""";
  }
}
