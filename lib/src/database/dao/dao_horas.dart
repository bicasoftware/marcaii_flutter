import 'package:marcaii_flutter/src/database/dao/base_dao.dart';
import 'package:marcaii_flutter/src/database/db_helper.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';

class DaoHoras implements BaseDao<Horas> {
  @override
  Future<void> delete(int i) async {
    final db = await getDB();
    return await db.delete(Horas.tableName);
  }

  @override
  Future<List<Horas>> fetchAll() async {
    final db = await getDB();
    final result = await db.query(Horas.tableName);
    return result.map(Horas.fromJson).toList();
  }

  @override
  Future<Horas> fetchById(int id) async {
    final db = await getDB();
    final result = await db.query(Horas.tableName, where: "id = ?", whereArgs: [id]);
    return Horas.fromJson(result[0]);
  }

  @override
  Future<Horas> insert(Horas model) async {
    final db = await getDB();
    final result = await db.insert(Horas.tableName, model.toJson());
    return model.copyWith(id: result);
  }

  @override
  Future<void> update(Horas model) async {
    final db = await getDB();
    return await db.update(
      Horas.tableName,
      model.toJson(),
      where: "id = ?",
      whereArgs: [model.id],
    );
  }
}
