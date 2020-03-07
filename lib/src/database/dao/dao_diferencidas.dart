import 'package:marcaii_flutter/src/database/dao/base_dao.dart';
import 'package:marcaii_flutter/src/database/db_helper.dart';
import 'package:marcaii_flutter/src/database/models/diferenciadas.dart';

class DaoDiferenciadas implements BaseDao<Diferenciadas> {
  @override
  Future<void> delete(int i) async {
    final db = await getDB();
    return await db.delete(Diferenciadas.tableName);
  }

  @override
  Future<List<Diferenciadas>> fetchAll() async {
    final db = await getDB();
    final result = await db.query(Diferenciadas.tableName);
    return result.map(Diferenciadas.fromJson).toList();
  }

  @override
  Future<Diferenciadas> fetchById(int id) async {
    final db = await getDB();
    final result = await db.query(Diferenciadas.tableName, where: "id = ?", whereArgs: [id]);
    return Diferenciadas.fromJson(result[0]);
  }

  @override
  Future<Diferenciadas> insert(Diferenciadas model) async {
    final db = await getDB();
    final result = await db.insert(Diferenciadas.tableName, model.toJson());
    return model.copyWith(id: result);
  }

  @override
  Future<void> update(Diferenciadas model) async {
    final db = await getDB();
    return await db.update(
      Diferenciadas.tableName,
      model.toJson(),
      where: "id = ?",
      whereArgs: [model.id],
    );
  }

  static Future<List<Diferenciadas>> fetchByEmprego(int empregoId) async {
    final db = await getDB();
    final result = await db.query(
      Diferenciadas.tableName,
      where: "${Diferenciadas.EMPREGO_ID} = ?",
      whereArgs: [empregoId],
    );

    return result.map(Diferenciadas.fromMap).toList();
  }

  static Future<void> deleteByEmprego(int emprego_id) async {
    final db = await getDB();
    return await db.delete(
      Diferenciadas.tableName,
      where: "emprego_id = ?",
      whereArgs: [emprego_id],
    );
  }
}
