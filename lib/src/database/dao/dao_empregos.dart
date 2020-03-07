import 'package:marcaii_flutter/src/database/dao/base_dao.dart';
import 'package:marcaii_flutter/src/database/dao/dao_diferencidas.dart';
import 'package:marcaii_flutter/src/database/dao/dao_horas.dart';
import 'package:marcaii_flutter/src/database/dao/dao_salarios.dart';
import 'package:marcaii_flutter/src/database/db_helper.dart';
import 'package:marcaii_flutter/src/database/models/diferenciadas.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/database/models/salarios.dart';

class DaoEmpregos {
  static Future<void> delete(int i) async {
    final db = await getDB();
    return await db.delete(
      Empregos.tableName,
      where: "id = ?",
      whereArgs: [i],
    );
  }

  static Future<List<Empregos>> fetchAll() async {
    final db = await getDB();
    final result = await db.query(Empregos.tableName);
    final empregos = result.map((e) => Empregos.fromMap(e)).toList();
    final resultList = <Empregos>[];

    for (final e in empregos) {
      final horas = await DaoHoras.fetchByEmprego(e.id);
      final salarios = await DaoSalarios.fetchByEmprego(e.id);
      final diferenciadas = await DaoDiferenciadas.fetchByEmprego(e.id);
      resultList.add(
        e.copyWith(
          horas: horas,
          salarios: salarios,
          diferenciadas: diferenciadas,
        ),
      );
    }

    return resultList;
  }

  static Future<Empregos> fetchById(int id) async {
    final db = await getDB();
    final result = await db.query(Empregos.tableName, where: "id = ?", whereArgs: [id]);
    return Empregos.fromJson(result[0]);
  }

  static Future<Empregos> insert(Empregos model) async {
    final db = await getDB();
    final data = model.toMap();
    final empregoId = await db.insert(Empregos.tableName, data);
    final salarios = <Salarios>[];
    final diferenciadas = <Diferenciadas>[];

    for (final salario in model.salarios) {
      salarios.add(
        await DaoSalarios.insert(salario.copyWith(emprego_id: empregoId)),
      );
    }

    for (final difer in model.diferenciadas) {
      final newDifer = difer.copyWith(emprego_id: empregoId);
      diferenciadas.add(await DaoDiferenciadas().insert(newDifer));
    }

    return model.copyWith(
      id: empregoId,
      diferenciadas: diferenciadas,
      salarios: salarios,
    );
  }

  static Future<void> update(Empregos model) async {
    final db = await getDB();
    await db.update(
      Empregos.tableName,
      model.toMap(),
      where: "id = ?",
      whereArgs: [model.id],
    );

    await DaoSalarios.deleteByEmprego(model.id);
    await DaoDiferenciadas.deleteByEmprego(model.id);

    for (final salario in model.salarios) {
      await DaoSalarios.insert(salario.copyWith(emprego_id: model.id));
    }

    for (final difer in model.diferenciadas) {
      await DaoDiferenciadas().insert(difer.copyWith(emprego_id: model.id));
    }
  }

  static Future<void> syncFromServer(List<Empregos> empregos) async {
    //TODO - Gerar lista de datas, calendario e parciais
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
