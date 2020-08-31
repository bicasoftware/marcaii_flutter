import 'package:marcaii_flutter/helpers.dart';
import 'package:marcaii_flutter/src/database/db_helper.dart';
import 'package:marcaii_flutter/src/database/models/salarios.dart';

class DaoSalarios {
  static Future<Salarios> salarios(int id) async {
    final db = await DbHelper().db;
    final result = await db.query(
      Salarios.tableName,
      where: 'id = ?',
      whereArgs: <Object>[id],
      limit: 1,
    );

    return Salarios.fromMap(result[0]);
  }

  static Future<List<Salarios>> fetchAll() async {
    final db = await getDB();
    final result = await db.query(Salarios.tableName);

    return result.map((s) => Salarios.fromMap(s)).toList();
  }

  static Future<Salarios> insert(Salarios salario) async {
    final db = await getDB();
    final id = await db.insert(
      Salarios.tableName,
      salario.toMap(),
    );
    return salario..id = id;
  }

  static Future<void> deleteSalario(Salarios salario) async {
    assert(salario.id.isNotNull);
    final db = await getDB();
    return await db.delete(
      Salarios.tableName,
      where: "id = ?",
      whereArgs: <Object>[salario.id],
    );
  }

  static Future<void> updateSalario(Salarios salario) async {
    assert(salario.id.isNotNull);
    final db = await DbHelper().db;
    await db.update(
      Salarios.tableName,
      salario.toMap(),
      where: "id = ?",
      whereArgs: <Object>[salario.id],
    );
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

  static Future<int> truncate() async {
    final db = await getDB();
    return await db.delete(Salarios.tableName);
  }
}
