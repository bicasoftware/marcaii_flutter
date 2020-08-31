import 'package:marcaii_flutter/src/database/dao/dao_diferencidas.dart';
import 'package:marcaii_flutter/src/database/dao/dao_horas.dart';
import 'package:marcaii_flutter/src/database/dao/dao_salarios.dart';
import 'package:marcaii_flutter/src/database/db_helper.dart';
import 'package:marcaii_flutter/src/database/models/diferenciadas.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/src/database/models/salarios.dart';

class DaoEmpregos {
  static Future<void> delete(int i) async {
    final db = await getDB();
    return await db.delete(
      Empregos.tableName,
      where: "id = ?",
      whereArgs: <Object>[i],
    );
  }

  static Future<List<Empregos>> fetchAll() async {
    final db = await getDB();
    final result = await db.query(Empregos.tableName);

    return result.map((e) => Empregos.fromMap(e)).toList()
      ..forEach(
        (e) async {
          final children = await Future.wait(
            [
              DaoHoras.fetchByEmprego(e.id),
              DaoSalarios.fetchByEmprego(e.id),
              DaoDiferenciadas.fetchByEmprego(e.id),
            ],
          );
          final List<Horas> horas = children[0] as List<Horas>;
          final List<Salarios> salarios = children[1] as List<Salarios>;
          final List<Diferenciadas> diferenciadas = children[2] as List<Diferenciadas>;
          e
            ..horas = horas
            ..salarios = salarios
            ..diferenciadas = diferenciadas
            ..calendario = [];
        },
      );
  }

  static Future<Empregos> fetchById(int id) async {
    final db = await getDB();
    final result = await db.query(Empregos.tableName, where: "id = ?", whereArgs: <Object>[id]);
    return Empregos.fromMap(result[0]);
  }

  static Future<Empregos> insertWithChildren(Empregos model) async {
    final db = await getDB();
    final empregoId = await db.insert(Empregos.tableName, model.toMap());
    final salarios = <Salarios>[];
    final diferenciadas = <Diferenciadas>[];

    for (final salario in model.salarios) {
      salarios.add(
        await DaoSalarios.insert(salario..emprego_id = empregoId),
      );
    }

    for (final difer in model.diferenciadas) {
      final newDifer = difer..emprego_id = empregoId;
      diferenciadas.add(await DaoDiferenciadas.insert(newDifer));
    }

    return model
      ..id = empregoId
      ..diferenciadas = diferenciadas
      ..salarios = salarios
      ..calendario = []
      ..horas = [];
  }

  static Future<Empregos> insert(Empregos emprego) async {
    final db = await getDB();
    final emprego_id = await db.insert(Empregos.tableName, emprego.toMap());

    return emprego..id = emprego_id;
  }

  static Future<void> update(Empregos model) async {
    final db = await getDB();
    await db.update(
      Empregos.tableName,
      model.toMap(),
      where: "id = ?",
      whereArgs: <Object>[model.id],
    );

    await DaoSalarios.deleteByEmprego(model.id);
    await DaoDiferenciadas.deleteByEmprego(model.id);

    for (final salario in model.salarios) {
      await DaoSalarios.insert(salario..emprego_id = model.id);
    }

    for (final difer in model.diferenciadas) {
      await DaoDiferenciadas.insert(difer..emprego_id = model.id);
    }
  }

  static Future<int> truncate() async {
    final db = await getDB();
    return await db.delete(Empregos.tableName);
  }
}
