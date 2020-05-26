import 'package:jiffy/jiffy.dart';
import 'package:marcaii_flutter/strings.dart';

class Vigencia {
  Vigencia({int ano, int mes}) {
    this.ano = ano;
    this.mes = mes;
  }

  Vigencia.fromString(String vigencia) {
    final vig = parseVigencia(vigencia);
    mes = vig[0];
    ano = vig[1];
  }

  Vigencia.fromDateTime(DateTime date) {
    ano = date.year;
    mes = date.month;
  }

  int ano, mes;

  void incMonth() {
    if (mes == 12) {
      mes = 1;
      ano = ano + 1;
    } else {
      mes++;
    }
  }

  void decMonth() {
    if (mes == 1) {
      mes = 12;
      ano = ano - 1;
    } else {
      mes--;
    }
  }

  List<DateTime> getDateRange(int diaFechamento) {
    final termino = DateTime(ano, mes, diaFechamento, 0, 0, 0);
    final inicio = Jiffy(termino)
      ..subtract(months: 1)
      ..add(days: 1);

    return <DateTime>[inicio.dateTime, termino];
  }

  String get vigencia => formatVigencia(ano, mes);
  String get vigenciaExtenso => "${Consts.meses[mes - 1]}/$ano";

  static String formatVigencia(int ano, int mes) {
    return "${_rightIndexMonth(mes)}/$ano";
  }

  static List<int> parseVigencia(String vigencia) {
    return vigencia.split("/").map(int.parse).toList();
  }

  static String _rightIndexMonth(int mes) {
    return (mes).toString().padLeft(2, "0");
  }

  bool compare<T>(T other) {
    if (hashCode == other.hashCode) {
      return true;
    } else if (other is String) {
      return vigencia == other;
    } else if (other is Vigencia) {
      return vigencia == other.vigencia;
    }

    return false;
  }
}
