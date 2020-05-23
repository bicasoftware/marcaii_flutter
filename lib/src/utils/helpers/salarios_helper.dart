import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:marcaii_flutter/src/database/models/salarios.dart';

extension SalariosHelper on Salarios {
  Salarios forFirstSync(int emprego_id) {
    return Salarios(
      id: null,
      emprego_id: emprego_id,
      valor: valor,
      vigencia: vigencia,
      ativo: ativo,
    );
  }

  DateTime vigenciaAsDate(int fechamento) {
    final splitVigencia = vigencia.split("/").map(int.parse).toList();

    final ano = splitVigencia.last;
    final mes = splitVigencia.first;

    final dt = DateTime(ano, mes, fechamento + 1);
    final r = Jiffy(dt).subtract(months: 1);
    return r;
  }

  String valorAsString() {
    return NumberFormat.simpleCurrency(locale: "pt_Br").format(valor);
  }
}
