import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/src/state/totais_domain/totais.dart';
import 'package:marcaii_flutter/src/views/view_parciais/totais_info_header.dart';
import 'package:marcaii_flutter/src/views/view_parciais/totais_info_row.dart';
import 'package:marcaii_flutter/src/views/view_parciais/totais_list_item.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:marcaii_flutter/src/utils/helpers/hora_helper.dart';

class TotaisContent extends StatelessWidget {
  const TotaisContent({
    @required this.color,
    @required this.label,
    @required this.totais,
    @required this.pos,
    @required this.horas,
    Key key,
  }) : super(key: key);

  final Color color;
  final String label;
  final Totais totais;
  final int pos;
  final List<Horas> horas;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            TotaisInfoHeader(
              color: color,
              porcentagem: totais.items[pos].porcentagem,
              title: label,
            ),
            const Divider(indent: 8, endIndent: 8, height: 0),
            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    TotaisInfoRow(
                      icon: LineAwesomeIcons.clock_o,
                      label: Strings.horasExtras,
                      value: "3:40 horas",
                    ),
                    const SizedBox(height: 8),
                    TotaisInfoRow(
                      icon: LineAwesomeIcons.money,
                      label: Strings.totalReceber,
                      value: "36,23 R\$",
                    ),
                    const Divider(),
                    Expanded(
                      child: ListView.separated(
                        itemCount: horas.length,
                        separatorBuilder: (_, i) => const SizedBox(height: 4),
                        itemBuilder: (_, i) {
                          final hora = horas[i];
                          return TotaisListItem(
                            color: color,
                            data: hora.data,
                            minutes: hora.difMinutes(),
                          );
                        }
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
