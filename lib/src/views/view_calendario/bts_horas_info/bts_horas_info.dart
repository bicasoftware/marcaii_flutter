import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/views/view_calendario/models/calendario_child.dart';
import 'package:marcaii_flutter/src/utils/double_utils.dart';
import 'package:marcaii_flutter/src/utils/hora_calc.dart';
import 'package:marcaii_flutter/src/views/widgets/bottomsheeet_header.dart';
import 'package:marcaii_flutter/src/utils/helpers/date_helper.dart';
import 'package:marcaii_flutter/src/utils/helpers/hora_helper.dart';
import 'package:flutter_utils/context_helper.dart';
import 'package:marcaii_flutter/src/views/widgets/light_container.dart';
import 'package:marcaii_flutter/strings.dart';

class BtsHorasInfo extends StatelessWidget {
  const BtsHorasInfo({
    Key key,
    this.calendarioChild,
    this.emprego,
    this.onDelete,
  }) : super(key: key);

  final void Function(CalendarioChild calendarioChild) onDelete;
  final CalendarioChild calendarioChild;
  final Empregos emprego;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          BottomsheetHeader(
            title: "Dia: ${calendarioChild.date.asString()}",
            onPressed: () => context.goBack(true),
            icon: const Icon(Icons.delete_sweep, color: Colors.red),
            hasDivider: false,
          ),
          LightContainer(
            padding: EdgeInsets.zero,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Consts.horaColor[calendarioChild.hora.tipo],
              ),
              title: _getTitle(),
              subtitle: Text("${calendarioChild.hora.difEstenso()} | $valorPorcentagem"),
              trailing: Text(
                actualPorcentagem,
                style: context.textTheme.button.copyWith(
                  color: Consts.horaColor[calendarioChild.hora.tipo],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String get actualPorcentagem {
    final porcentagem = CalcHelper.getPorcentagem(calendarioChild.hora, emprego);
    return "$porcentagem %";
  }

  String get valorPorcentagem {
    final porcentagem = CalcHelper.getPorcentagem(calendarioChild.hora, emprego);
    final salario = CalcHelper.getActualSalario(
      emprego.fechamento,
      calendarioChild.date,
      emprego.salarios,
    );

    final salarioHora = salario / (emprego.carga_horaria);
    final valorPorc = salarioHora * (porcentagem / 100);
    final total = (valorPorc / 60) * calendarioChild.hora.difMinutes();

    return doubleToCurrency(total);
  }

  Widget _getTitle() {
    return Text(
      "${Strings.das} ${calendarioChild.hora.inicio} ${Strings.ate} ${calendarioChild.hora.termino}",
    );
  }
}
