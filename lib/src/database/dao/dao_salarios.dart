import 'package:marcaii_flutter/src/database/db_helper.dart';
import 'package:marcaii_flutter/src/database/models/salarios.dart';

class DaoSalarios {
  static Future<Salarios> insert(Salarios salario) async {
    final db = await getDB();
    final id = await db.insert(
      Salarios.tableName,
      salario.toMap(),
    );
    return salario..id = id;
  }

  static Future<List<Salarios>> fetchByEmprego(int empregoId) async {
    final db = await getDB();
    final result = await db.query(
      Salarios.tableName,
      where: "${Salarios.EMPREGO_ID} = ?",
      whereArgs: <Object>[empregoId],
    );

    return result.map((s) => Salarios.fromMap(s)).toList();
  }

  static Future<void> deleteByEmprego(int emprego_id) async {
    final db = await getDB();
    return await db.delete(
      Salarios.tableName,
      where: "emprego_id = ?",
      whereArgs: <Object>[emprego_id],
    );
  }
}
