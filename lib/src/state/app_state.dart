import 'package:marcaii_flutter/src/database/dao/dao_empregos.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/strings.dart';

class AppState {
  AppState({
    this.token,
    this.empregos,
  }) {
    final dt = DateTime.now();
    ano = dt.year;
    mes = dt.month;
    navPosition = empregos.isNotEmpty ? 1 : 0;
  }

  String token;
  List<Empregos> empregos;

  int mes, ano, navPosition;

  String get vigencia => "${Consts.meses[mes - 1]}/$ano";

  void addMes() {
    if (mes == 12) {
      mes = 1;
      ano = ano + 1;
    } else {
      mes++;
    }
  }

  void decMes() {
    if (mes == 1) {
      mes = 12;
      ano = ano - 1;
    } else {
      mes--;
    }
  }

  void setAno(int ano) => this.ano = ano;

  void setNavPosition(int pos) => this.navPosition = pos;

  Future<void> addEmprego(Empregos e) async {
    final newEmprego = await DaoEmpregos.insert(e);
    empregos.add(newEmprego);
  }

  Future<void> removeEmprego(Empregos e) async {
    await DaoEmpregos.delete(e.id);
    empregos.removeWhere((emprego) => emprego.id == e.id);
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
}
