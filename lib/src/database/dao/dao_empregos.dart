import 'package:marcaii_flutter/src/database/dao/dao_diferencidas.dart';
import 'package:marcaii_flutter/src/database/dao/dao_horas.dart';
import 'package:marcaii_flutter/src/database/dao/dao_salarios.dart';
import 'package:marcaii_flutter/src/database/db_helper.dart';
import 'package:marcaii_flutter/src/database/models/diferenciadas.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/database/models/salarios.dart';
import 'package:marcaii_flutter/src/state/calendario.dart';
import 'package:marcaii_flutter/src/utils/calendar_generator.dart';
import 'package:marcaii_flutter/src/utils/vigencia.dart';

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
    final dt = DateTime.now();

    for (final e in empregos) {
      final horas = await DaoHoras.fetchByEmprego(e.id);
      final salarios = await DaoSalarios.fetchByEmprego(e.id);
      final diferenciadas = await DaoDiferenciadas.fetchByEmprego(e.id);
      resultList.add(
        e.copyWith(
          horas: horas,
          salarios: salarios,
          diferenciadas: diferenciadas,
          calendario: [
            Calendario(
              vigencia: Vigencia.fromDateTime(dt).vigencia,
              items: CalendarGenerator.generate(dt.year, dt.month, horas),
            ),
          ],
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

  static Future<Empregos> insertWithChildren(Empregos model) async {
    final db = await getDB();
    final empregoId = await db.insert(Empregos.tableName, model.toMap());
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
      calendario: [],
      horas: []
    );
  }

  static Future<Empregos> insert(Empregos emprego) async {
    final db = await getDB();
    final emprego_id = await db.insert(Empregos.tableName, emprego.toMap());

    return emprego.copyWith(id: emprego_id);
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

  static Future<int> truncate() async {
    final db = await getDB();
    return await db.delete(Empregos.tableName);
  }

  static Future<void> syncFromServer(List<Empregos> empregos) async {
    for (final emprego in empregos) {
      final e = await insert(emprego.forFirstSync());

      for (final hora in emprego.horas) {
        // e.addHora(await DaoHoras.insert(hora.forFirstSync(e.id)));
        await DaoHoras.insert(hora.forFirstSync(e.id));
      }

      for (final salario in emprego.salarios) {
        await DaoSalarios.insert(salario.forFirstSync(e.id));
        // e.addSalario(await DaoSalarios.insert(salario.forFirstSync(e.id)));
      }

      for (final difer in emprego.diferenciadas) {
        // await DaoDiferenciadas().insert(difer.forFirstSync(e.id));
        await DaoDiferenciadas().insert(difer.forFirstSync(e.id));
      }
    }
  }
}
