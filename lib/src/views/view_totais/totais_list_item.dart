import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:marcaii_flutter/helpers.dart';
import 'package:marcaii_flutter/src/state/totais/totais_horas.dart';
import 'package:marcaii_flutter/src/utils/double_utils.dart';
import 'package:marcaii_flutter/strings.dart';

class TotaisListItem extends StatelessWidget {
  const TotaisListItem({
    @required this.hora,
    Key key,
  }) : super(key: key);

  final TotaisHoras hora;

  Color get color => Consts.horaColor[hora.tipohora] ?? Colors.grey[500];

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: Icon(LineAwesomeIcons.calendar, color: color),
      title: Text(hora.date.asString()),
      subtitle: Text(
        "${MinutesHelper.minutesToHoras(hora.minutes)} | ${Consts.tipoHoraPlural[hora.tipohora]}",
      ),
      trailing: Text(
        doubleToCurrency(hora.valor),
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }
}
