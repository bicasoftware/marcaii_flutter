import 'package:marcaii_flutter/src/database/db_helper.dart';
import 'package:marcaii_flutter/src/database/models/diferenciadas.dart';

class DaoDiferenciadas {
  Future<void> delete(int i) async {
    final db = await getDB();
    return await db.delete(Diferenciadas.tableName);
  }

  Future<List<Diferenciadas>> fetchAll() async {
    final db = await getDB();
    final result = await db.query(Diferenciadas.tableName);
    return result.map(Diferenciadas.fromJson).toList();
  }

  Future<Diferenciadas> fetchById(int id) async {
    final db = await getDB();
    final result =
        await db.query(Diferenciadas.tableName, where: "id = ?", whereArgs: <Object>[id]);
    return Diferenciadas.fromJson(result[0]);
  }

  Future<Diferenciadas> insert(Diferenciadas model) async {
    final db = await getDB();
    final result = await db.insert(Diferenciadas.tableName, model.toMap());
    return model..id = result;
  }

  Future<void> update(Diferenciadas model) async {
    final db = await getDB();
    return await db.update(
      Diferenciadas.tableName,
      model.toJson(),
      where: "id = ?",
      whereArgs: <Object>[model.id],
    );
  }

  static Future<List<Diferenciadas>> fetchByEmprego(int empregoId) async {
    final db = await getDB();
    final result = await db.query(
      Diferenciadas.tableName,
      where: "${Diferenciadas.EMPREGO_ID} = ?",
      whereArgs: <Object>[empregoId],
      orderBy: Diferenciadas.WEEKDAY,
    );

    return result.map((d) => Diferenciadas.fromMap(d)).toList();
  }

  static Future<void> deleteByEmprego(int emprego_id) async {
    final db = await getDB();
    return await db.delete(
      Diferenciadas.tableName,
      where: "emprego_id = ?",
      whereArgs: <Object>[emprego_id],
    );
  }

  static Future<int> truncate() async {
    final db = await getDB();
    return await db.delete(Diferenciadas.tableName);
  }
}
