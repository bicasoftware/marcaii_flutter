import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/state/calendario/calendario_child.dart';
import 'package:marcaii_flutter/src/utils/double_utils.dart';
import 'package:marcaii_flutter/src/utils/hora_calc.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:marcaii_flutter/src/utils/helpers/hora_helper.dart';

class BtsHorasContent extends StatelessWidget {
  const BtsHorasContent({
    Key key,
    this.calendarChild,
    this.emprego,
  }) : super(key: key);

  final CalendarioChild calendarChild;
  final Empregos emprego;

  String get actualPorcentagem {
    final porcentagem = CalcHelper.getPorcentagem(calendarChild.hora, emprego);
    return "$porcentagem %";
  }

  String get valorPorcentagem {
    final porcentagem = CalcHelper.getPorcentagem(calendarChild.hora, emprego);
    final salario =
        CalcHelper.getActualSalario(emprego.fechamento, calendarChild.date, emprego.salarios);

    final salarioHora = salario / (emprego.carga_horaria);
    final valorPorc = salarioHora * (porcentagem / 100);
    final total = (valorPorc / 60) * calendarChild.hora.difMinutes();

    return doubleToCurrency(total);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          isThreeLine: true,
          leading: CircleAvatar(backgroundColor: calendarChild.hora.color),
          title: Text(Consts.tipoHora[calendarChild.hora.tipo]),
          subtitle: Text("$valorPorcentagem\n${calendarChild.hora.difEstenso()}"),
          trailing: Text(
            actualPorcentagem,
            style: Theme.of(context).textTheme.button.copyWith(color: calendarChild.hora.color),
          ),
        )
      ],
    );
  }
}
