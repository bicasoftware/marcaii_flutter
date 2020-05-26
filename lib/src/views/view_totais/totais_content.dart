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
      return Consts.tipoHora[tipo];
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
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                TotaisInfoRow(
                  icon: Icon(LineAwesomeIcons.clock_o),
                  label: Strings.horasExtras,
                  value: detalhe.minutos.toString(),
                ),
                const SizedBox(height: 8),
                TotaisInfoRow(
                  icon: Icon(LineAwesomeIcons.money),
                  label: Strings.totalReceber,
                  value: doubleToCurrency(detalhe.total),
                ),
                const Divider(),
                detalhe.horas.isNotEmpty
                    ? ListView.separated(
                        shrinkWrap: true,
                        itemCount: detalhe.horas.length,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (_, i) => const SizedBox(height: 4),
                        itemBuilder: (_, i) {
                          final hora = detalhe.horas[i];
                          return TotaisListItem(
                            data: hora.data,
                            minutes: hora.difMinutes(),
                          );
                        },
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
