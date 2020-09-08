import 'package:flutter/foundation.dart';
import 'package:marcaii_flutter/src/database/dao/dao_empregos.dart';
import 'package:marcaii_flutter/src/database/dao/dao_horas.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/src/utils/vigencia.dart';

class AppState {
  AppState({
    @required this.empregos,
  }) {
    vigencia = Vigencia.fromDateTime(DateTime.now());
  }

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
    empregos.firstWhere((emprego) => emprego.id == e.id)
      ..nome = e.nome
      ..ativo = e.ativo
      ..banco_horas = e.banco_horas
      ..carga_horaria = e.carga_horaria
      ..fechamento = e.fechamento
      ..porc = e.porc
      ..porc_completa = e.porc_completa
      ..saida = e.saida
      ..diferenciadas = e.diferenciadas
      ..salarios = e.salarios;
  }

  Future<void> addHora(Horas hora, Vigencia vigencia) async {
    hora = await DaoHoras.insert(hora);
    empregos.firstWhere((e) => e.id == hora.emprego_id).addHora(hora, vigencia);
  }

  Future<void> removeHora({
    @required Horas hora,
    @required int emprego_id,
  }) async {
    await DaoHoras.delete(hora.id);
    empregos.firstWhere((e) => e.id == emprego_id)..removeHora(hora);
    empregos.firstWhere((e) => e.id == emprego_id)
      ..calendario.firstWhere((c) => c.vigencia == vigencia.value).removeHora(hora.id);
  }
}
