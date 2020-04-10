import 'package:flutter_test/flutter_test.dart';
import 'package:marcaii_flutter/src/database/models/salarios.dart';
import 'package:marcaii_flutter/helpers.dart';
import 'package:marcaii_flutter/src/utils/hora_calc.dart';

void main() {
  test("vigencia as date", () {
    const s = Salarios(vigencia: "03/2010", ativo: true, valor: 1200.0);
    print(s.vigenciaAsDate(25));
  });

  test('actual salario', () {
    const fechamento = 25;
    final dataHora = DateTime(2010, 4, 25);

    final salarios = <Salarios>[
      const Salarios(
        ativo: true,
        valor: 1800.00,
        vigencia: "05/2010",
      ),
      const Salarios(
        ativo: true,
        valor: 1600.00,
        vigencia: "03/2010",
      ),
      const Salarios(
        ativo: true,
        valor: 1200.00,
        vigencia: "01/2010",
      ),
    ];

    // salarios.sort((f, s) => s.vigenciaAsDate(fechamento).compareTo(s.vigenciaAsDate(fechamento)));
    salarios.sort((f, s) => f.vigenciaAsDate(fechamento).compareTo(s.vigenciaAsDate(fechamento)));
    salarios.forEach((s) => print("${s.vigenciaAsDate(fechamento)} - ${s.valor}"));
    // final s = salarios.lastWhere((it) => dataHora.isBefore(it.vigenciaAsDate(fechamento)));
    final s = salarios.lastWhere((it) {
      return it.vigenciaAsDate(fechamento).isBefore(dataHora) ||
          it.vigenciaAsDate(fechamento).isSameDate(dataHora);
    });
    print("dataHora: $dataHora - ${s.vigenciaAsDate(fechamento)} ${s.valor}");
    print(CalcHelper.getActualSalario(fechamento, dataHora, salarios));

/*     final s = salarios.lastWhere((s) {
      print("vigencia as Date ${s.vigenciaAsDate(fechamento)}");
      print("dataHora $dataHora");
      return dataHora.isBefore(s.vigenciaAsDate(fechamento));
    });
    print(s.vigencia);
    print(s.valor); */
  });
}
