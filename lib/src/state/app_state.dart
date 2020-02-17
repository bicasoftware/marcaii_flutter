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
  }

  String token;
  List<Empregos> empregos;

  int mes, ano;
  String get vigencia => "${Consts.meses[mes-1]}/$ano";

  void addMes() {
    if (mes == 12) {
      mes = 1;
      ano = ano+1;
    } else {
      mes++;
    }
  }

  void decMes() {
    if (mes == 1) {
      mes = 12;
      ano = ano -1;
    } else {
      mes--;
    }
  }

  void setAno(int ano) => this.ano = ano;
}
