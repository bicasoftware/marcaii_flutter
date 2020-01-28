import 'package:marcaii_flutter/src/database/dao/base_dao.dart';
import 'package:marcaii_flutter/src/database/db_helper.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';

class DaoEmpregos implements BaseDao<Empregos> {
  @override
  Future<void> delete(int i) async {
    final db = await getDB();
    return await db.delete(Empregos.tableName);
  }

  @override
  Future<List<Empregos>> fetchAll() async {
    final db = await getDB();
    final result = await db.query(Empregos.tableName);
    return result.map(Empregos.fromJson).toList();
  }

  @override
  Future<Empregos> fetchById(int id) async {
    final db = await getDB();
    final result = await db.query(Empregos.tableName, where: "id = ?", whereArgs: [id]);
    return Empregos.fromJson(result[0]);
  }

  @override
  Future<Empregos> insert(Empregos model) async {
    final db = await getDB();
    final result = await db.insert(Empregos.tableName, model.toJson());
    return model.copyWith(id: result);
  }

  @override
  Future<void> update(Empregos model) async {
    final db = await getDB();
    return await db.update(
      Empregos.tableName,
      model.toJson(),
      where: "id = ?",
      whereArgs: [model.id],
    );
  }
}
