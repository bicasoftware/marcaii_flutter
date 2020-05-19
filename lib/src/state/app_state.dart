import 'package:flutter/foundation.dart';
import 'package:marcaii_flutter/src/database/dao/dao_empregos.dart';
import 'package:marcaii_flutter/src/database/dao/dao_horas.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/src/utils/vigencia.dart';

class AppState {
  AppState({
    this.token,
    this.empregos,
  }) {
    vigencia = Vigencia.fromDateTime(DateTime.now());
  }

  String token;
  Vigencia vigencia;
  int navPosition = 0;
  List<Empregos> empregos;

  void setNavPosition(int pos) => navPosition = pos;

  void addMes() => vigencia.incMonth();

  void decMes() => vigencia.decMonth();

  void setVigencia(Vigencia vigencia) {
    this.vigencia = vigencia;
  }

  Future<void> addEmprego(Empregos e) async {
    final newEmprego = await DaoEmpregos.insertWithChildren(e);
    empregos.add(newEmprego);
    navPosition = 0;
  }

  Future<void> removeEmprego(Empregos e) async {
    await DaoEmpregos.delete(e.id);
    empregos.removeWhere((emprego) => emprego.id == e.id);
    navPosition = 0;
  }

  Future<void> updateEmprego(Empregos e) async {
    await DaoEmpregos.update(e);
    final index = empregos.indexWhere((emprego) => emprego.id == e.id);
    empregos[index] = empregos[index].copyWith(
      nome: e.nome,
      ativo: e.ativo,
      banco_horas: e.banco_horas,
      carga_horaria: e.carga_horaria,
      fechamento: e.fechamento,
      porc: e.porc,
      porc_completa: e.porc_completa,
      saida: e.saida,
      diferenciadas: e.diferenciadas,
      salarios: e.salarios,
    );
  }

  Future<void> addHora(Horas hora, Vigencia vigencia) async {
    hora = await DaoHoras.insert(hora);
    empregos.firstWhere((e) => e.id == hora.emprego_id).addHora(hora, vigencia);
  }

  //immutability sucks
  Future<void> removeHora({
    @required Horas hora,
    @required int emprego_id,
  }) async {
    final indexEmprego = empregos.indexWhere((e) => e.id == emprego_id);
    await DaoHoras.delete(hora.id);
    empregos[indexEmprego].removeHora(hora);
    final _calendario = [...empregos[indexEmprego].calendario];
    final indexCalendario = _calendario.indexWhere((c) => c.vigencia == vigencia.vigencia);
    _calendario.replaceRange(
      indexCalendario,
      indexCalendario + 1,
      [_calendario[indexCalendario].removeHora(hora.id)],
    );
    empregos[indexEmprego] = empregos[indexEmprego].copyWith(calendario: _calendario);
  }
}
