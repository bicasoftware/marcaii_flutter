import 'package:marcaii_flutter/src/utils/helpers/date_helper.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/src/database/models/salarios.dart';
import 'package:marcaii_flutter/src/utils/helpers/salarios_helper.dart';

class CalcHelper {
  static int getPorcentagem(Horas hora, Empregos emprego) {
    switch (hora.tipo) {
      case 0:
        return emprego.porc;
        break;
      case 1:
        return emprego.porc_completa;
        break;
      case 2:
        return emprego.diferenciadas.firstWhere((d) => d.weekday == hora.data.indexWeekday()).porc;
        break;
      default:
        return emprego.porc;
    }
  }

  static double getActualSalario(int fechamento, DateTime dataHora, List<Salarios> salarios) {
    final listSalarios = [...salarios];
    listSalarios
        .sort((f, s) => f.vigenciaAsDate(fechamento).compareTo(s.vigenciaAsDate(fechamento)));

    final sal = listSalarios.lastWhere(
      (it) =>
          it.vigenciaAsDate(fechamento).isBefore(dataHora) ||
          it.vigenciaAsDate(fechamento).isSameDate(dataHora),
    );

    if (sal == null) {
      throw Exception("Salário não encontrado");
    }
    return sal.valor;
  }

  static double getSalarioMinuto(
    Empregos emprego,
    DateTime inicio,
  ) {
    final salario = CalcHelper.getActualSalario(emprego.fechamento, inicio, emprego.salarios);
    final salarioHora = salario / (emprego.carga_horaria);
    return salarioHora / 60;
  }
}
