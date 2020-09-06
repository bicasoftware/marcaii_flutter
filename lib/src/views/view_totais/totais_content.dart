import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:marcaii_flutter/src/state/totais/totais_detalhes.dart';
import 'package:marcaii_flutter/src/utils/double_utils.dart';
import 'package:marcaii_flutter/src/views/view_totais/totais_info_header.dart';
import 'package:marcaii_flutter/src/views/view_totais/totais_info_row.dart';
import 'package:marcaii_flutter/src/views/view_totais/totais_list_item.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:marcaii_flutter/helpers.dart';

class TotaisContent extends StatelessWidget {
  const TotaisContent({
    @required this.tipo,
    @required this.detalhe,
    Key key,
  }) : super(key: key);

  final TotaisDetalhe detalhe;
  final int tipo;

  String get label {
    if (tipo == 2 && detalhe.weekday != null) {
      return Consts.weekDayExtenso[detalhe.weekday];
    } else {
      return Consts.tipoHoraPlural[tipo];
    }
  }

  Color get color => Consts.horaColor[tipo];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
      decoration: BoxDecoration(
        color: theme.cardColor,
        border: Border.all(
          color: theme.dividerColor,
          width: .6,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TotaisInfoHeader(
            color: color,
            porcentagem: detalhe.porcentagem,
            title: label,
          ),
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                TotaisInfoRow(
                  icon: const Icon(LineAwesomeIcons.clock_o),
                  label: Strings.horasExtras,
                  value: MinutesHelper.minutesToHoras(detalhe.minutos),
                ),
                const SizedBox(height: 8),
                TotaisInfoRow(
                  icon: const Icon(LineAwesomeIcons.money),
                  label: Strings.totalReceber,
                  value: doubleToCurrency(detalhe.total),
                ),
                const Divider(),
                detalhe.horas.isNotEmpty
                    ? Column(
                        children: <Widget>[
                          for (final hora in detalhe.horas) TotaisListItem(hora: hora)
                        ],
                      )
                    : Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        width: double.maxFinite,
                        child: Text(
                          Strings.nenhumaHora,
                          style: Theme.of(context).textTheme.caption,
                          textAlign: TextAlign.start,
                        ),
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
