import 'package:marcaii_flutter/src/database/db_helper.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';

class DaoHoras {
  static Future<void> delete(int i) async {
    final db = await getDB();
    return await db.delete(Horas.tableName);
  }

  static Future<List<Horas>> fetchAll() async {
    final db = await getDB();
    final result = await db.query(Horas.tableName);
    return result.map(Horas.fromJson).toList();
  }

  static Future<Horas> fetchById(int id) async {
    final db = await getDB();
    final result = await db.query(Horas.tableName, where: "id = ?", whereArgs: <Object>[id]);
    return Horas.fromJson(result[0]);
  }

  static Future<Horas> insert(Horas model) async {
    final db = await getDB();
    final id = await db.insert(Horas.tableName, model.toJson());
    return model..id = id;
    // return model.copyWith(id: id);
  }

  static Future<void> update(Horas model) async {
    final db = await getDB();
    return await db.update(
      Horas.tableName,
      model.toJson(),
      where: "id = ?",
      whereArgs: <Object>[model.id],
    );
  }

  static Future<List<Horas>> fetchByEmprego(int empregoId) async {
    final db = await getDB();
    final result = await db.query(
      Horas.tableName,
      where: "${Horas.EMPREGO_ID} = ?",
      whereArgs: <Object>[empregoId],
    );

    return result.map(Horas.fromJson).toList();
  }

  static Future<int> truncate() async {
    final db = await getDB();
    return await db.delete(Horas.tableName);
  }
}
