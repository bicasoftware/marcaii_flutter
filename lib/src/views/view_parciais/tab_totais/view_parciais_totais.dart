import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:marcaii_flutter/helpers.dart';
import 'package:marcaii_flutter/src/state/totais_domain/totais.dart';
import 'package:marcaii_flutter/src/state/totais_domain/totais_item.dart';
import 'package:marcaii_flutter/src/views/view_parciais/tab_totais/parciais_total_container.dart';
import 'package:marcaii_flutter/strings.dart';

class ViewParciaisTotais extends StatelessWidget {
  const ViewParciaisTotais({
    @required this.totais,
    Key key,
  })  : assert(totais != null),
        super(key: key);

  final Totais totais;

  double get totalReceber => totais.items.fold(0.0, (double sum, TotaisItem t) => sum + t.total);

  int get totalMinutos => totais.items.fold(0, (int sum, t) => sum + t.minutos);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(
            LineAwesomeIcons.calendar,
            color: theme.accentColor,
          ),
          title: Text(
            "Totais do mês de ${Consts.meses[totais.mes]}",
            style: theme.textTheme.subtitle2.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            "Entre ${totais.inicio.asString()} e ${totais.termino.asString()}",
            style: theme.textTheme.subtitle1.copyWith(
              color: theme.accentColor,
            ),
          ),
        ),
        const Divider(
          indent: 16,
          endIndent: 16,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: totais.items.length,
            itemBuilder: (_, i) {
              return ParciaisTotalContainer(totais: totais.items[i]);
            },
          ),
        ),
        /* BottomAppBar(
          elevation: 2,
          child: Container(
            width: double.maxFinite,
            height: kToolbarHeight,
            child: Column(
              children: <Widget>[
                Text(
                  "${Strings.totalReceber} - ${totalReceber}",
                  style: theme.textTheme.subtitle1,
                ),
                const SizedBox(height: 8),
                Text(
                  "${Strings.totalHorasPeriodo} - ${totalMinutos}",
                  style: theme.textTheme.subtitle1,
                ),
              ],
            ),
          ),
        ) */
      ],
    );
  }
}
