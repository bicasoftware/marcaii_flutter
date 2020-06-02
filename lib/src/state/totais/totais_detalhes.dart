import 'package:flutter/foundation.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/src/state/totais/totais_horas.dart';

class TotaisDetalhe {
  TotaisDetalhe({
    @required this.minutos,
    @required this.total,
    @required this.porcentagem,
    @required this.weekday,
    @required this.horas,
  });

  int minutos, porcentagem, weekday;
  double total;
  List<TotaisHoras> horas;

  void update({Horas hora, double total, int minutos}) {
    this.minutos += minutos;
    this.total += total;

    horas.add(
      TotaisHoras(
        date: hora.data,
        minutes: minutos,
        tipohora: hora.tipo,
        valor: total,
      ),
    );
  }

  void addMinutos(int minutos) => this.minutos += minutos;

  void addTotal(double total) => this.total += total;

  void addHoras(Horas hora, double valor, int minutos) {
    horas.add(
      TotaisHoras(
        date: hora.data,
        minutes: minutos,
        tipohora: hora.tipo,
        valor: valor,
      ),
    );
  }
}
