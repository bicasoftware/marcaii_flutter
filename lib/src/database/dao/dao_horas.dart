import 'package:marcaii_flutter/src/database/db_helper.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';

class DaoHoras {
  static Future<void> delete(int id) async {
    final db = await getDB();
    return await db.delete(
      Horas.tableName,
      where: "${Horas.ID} = ?",
      whereArgs: <Object>[id],
    );
  }

  static Future<Horas> insert(Horas model) async {
    final db = await getDB();
    final id = await db.insert(Horas.tableName, model.toMap());
    return model..id = id;
  }

  static Future<List<Horas>> fetchByEmprego(int empregoId) async {
    final db = await getDB();
    final result = await db.query(
      Horas.tableName,
      where: "${Horas.EMPREGO_ID} = ?",
      whereArgs: <Object>[empregoId],
    );

    return result.map((h) => Horas.fromMap(h)).toList();
  }
}
