import 'package:marcaii_flutter/src/database/dao/base_dao.dart';
import 'package:marcaii_flutter/src/database/dao/dao_diferencidas.dart';
import 'package:marcaii_flutter/src/database/dao/dao_horas.dart';
import 'package:marcaii_flutter/src/database/dao/dao_salarios.dart';
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
    final data = model.toMap();
    final result = await db.insert(Empregos.tableName, data);
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

  Future<void> syncFromServer(List<Empregos> empregos) async {
    for (var emprego in empregos) {
      final e = await insert(emprego.copyWith());

      for (final hora in emprego.horas) {
        await DaoHoras().insert(hora.copyWith(emprego_id: e.id));
      }

      for (final salario in emprego.salarios) {
        final s = salario.copyWith(emprego_id: e.id);
        await DaoSalarios.insert(s);
      }

      for (final difer in emprego.diferenciadas) {
        await DaoDiferenciadas().insert(difer.copyWith(emprego_id: e.id));
      }
    }
  }
}
