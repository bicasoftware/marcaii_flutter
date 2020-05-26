import 'package:marcaii_flutter/helpers.dart';
import 'package:marcaii_flutter/src/database/dao/dao_diferencidas.dart';
import 'package:marcaii_flutter/src/database/dao/dao_horas.dart';
import 'package:marcaii_flutter/src/database/dao/dao_salarios.dart';
import 'package:marcaii_flutter/src/database/db_helper.dart';
import 'package:marcaii_flutter/src/database/models/diferenciadas.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/database/models/salarios.dart';
import 'package:marcaii_flutter/src/state/calendario/calendario.dart';
import 'package:marcaii_flutter/src/utils/calendar_generator.dart';
import 'package:marcaii_flutter/src/utils/vigencia.dart';

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
    final dt = DateTime.now();
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
          e
            ..horas = children[0]
            ..salarios = children[1]
            ..diferenciadas = children[2]
            ..calendario = [
              Calendario(
                vigencia: Vigencia.fromDateTime(dt).vigencia,
                items: CalendarGenerator.generate(dt.year, dt.month, children[0]),
              ),
            ];
        },
      );
  }

  static Future<Empregos> fetchById(int id) async {
    final db = await getDB();
    final result = await db.query(Empregos.tableName, where: "id = ?", whereArgs: <Object>[id]);
    return Empregos.fromJson(result[0]);
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
      diferenciadas.add(await DaoDiferenciadas().insert(newDifer));
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
      await DaoDiferenciadas().insert(difer..emprego_id = model.id);
    }
  }

  static Future<int> truncate() async {
    final db = await getDB();
    return await db.delete(Empregos.tableName);
  }

  static Future<void> syncFromServer(List<Empregos> empregos) async {
    for (final emprego in empregos) {
      final e = await insert(emprego.forFirstSync());

      for (final hora in emprego.horas) {
        await DaoHoras.insert(hora.forFirstSync(e.id));
      }

      for (final salario in emprego.salarios) {
        await DaoSalarios.insert(salario.forFirstSync(e.id));
      }

      for (final difer in emprego.diferenciadas) {
        await DaoDiferenciadas().insert(difer.forFirstSync(e.id));
      }
    }
  }
}
