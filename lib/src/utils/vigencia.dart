import 'package:marcaii_flutter/strings.dart';

class Vigencia {
  Vigencia({int ano, int mes}) {
    this.ano = ano;
    this.mes = mes;
  }

  Vigencia.fromString(String vigencia) {
    final vig = parseVigencia(vigencia);
    this.mes = vig[0];
    this.ano = vig[1];
  }

  Vigencia.fromDateTime(DateTime date) {
    this.ano = date.year;
    this.mes = date.month;
  }

  int ano, mes;

  void incMonth() {
    if (mes == 12) {
      mes = 1;
      ano = ano + 1;
    } else {
      mes++;
    }
    print(vigencia);
  }

  void decMonth() {
    if (mes == 1) {
      mes = 12;
      ano = ano - 1;
    } else {
      mes--;
    }
    print(vigencia);
  }

  void setYear(int ano) => this.ano = ano;

  String get vigencia => formatVigencia(ano, mes);
  String get vigenciaExtenso => "${Consts.meses[mes-1]}/$ano";

  static String formatVigencia(int ano, int mes) {
    return "${_rightIndexMonth(mes)}/$ano";
  }

  static List<int> parseVigencia(String vigencia) {
    return vigencia.split("/").map(int.parse).toList();
  }

  static String _rightIndexMonth(int mes) {
    return (mes).toString().padLeft(2, "0");
  }
}
