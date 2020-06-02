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
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Icon(LineAwesomeIcons.calendar, color: color),
                const SizedBox(width: 8),
                Text(
                  hora.date.asString(),
                  style: theme.textTheme.bodyText1.copyWith(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Icon(LineAwesomeIcons.clock_o, color: color),
                Text(
                  "${MinutesHelper.minutesToHoras(hora.minutes)}",
                  style: theme.textTheme.caption.copyWith(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(LineAwesomeIcons.money, color: color),
                Text(
                  doubleToCurrency(hora.valor),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
