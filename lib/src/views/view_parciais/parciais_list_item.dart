import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/src/utils/double_utils.dart';
import 'package:marcaii_flutter/src/utils/helpers/hora_helper.dart';

class ParciaisListItem extends StatelessWidget {
  const ParciaisListItem({
    @required this.hora,
    @required this.porc,
    @required this.valorReceber,
    Key key,
  }) : super(key: key);

  final Horas hora;
  final int porc;
  final double valorReceber;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: .2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(
                "10/01/2020",
                style: theme.textTheme.subhead.copyWith(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                hora.getTipo(),
                style: Theme.of(context)
                    .textTheme
                    .subtitle
                    .copyWith(color: hora.color, fontStyle: FontStyle.italic),
              ),
              trailing: Text(
                "30 %",
                style: theme.textTheme.subtitle,
              ),
            ),
            const Divider(height: 0, indent: 16, endIndent: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ParciaisListDetail(
                    label: "Tempo",
                    value: hora.difEstenso(),
                  ),
                  const SizedBox(height: 8),
                  ParciaisListDetail(
                    label: "Valor a receber",
                    value: doubleToCurrency(valorReceber),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ParciaisListDetail extends StatelessWidget {
  const ParciaisListDetail({
    @required this.label,
    @required this.value,
    Key key,
  }) : super(key: key);

  final String label, value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text(label, style: theme.textTheme.subtitle.copyWith(color: Colors.black54)),
        const Spacer(),
        Text(
          value,
          style: theme.textTheme.subhead.copyWith(
            color: theme.accentColor,
          ),
        ),
      ],
    );
  }
}
