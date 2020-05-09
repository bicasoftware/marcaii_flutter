import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/state/totais_domain/totais_item.dart';
import 'package:marcaii_flutter/strings.dart';

class ParciaisTotalContainer extends StatelessWidget {
  const ParciaisTotalContainer({
    @required this.totais,
    Key key,
  }) : super(key: key);

  final TotaisItem totais;

  String get label {
    switch (totais.tipo) {
      case 0:
        return Strings.normais;
        break;
      case 1:
        return Strings.feriados;
        break;
      case 2:
        return Consts.weekDayExtenso[totais.weekday];
        break;
      case 3:
        return Strings.totais;
        break;
      default:
        return "";
        break;
    }
  }

  Color get color => Consts.horaColor[totais.tipo];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Icon(Icons.view_compact, color: color),
        title: Text(
          "${totais.porcentagem} %",
          style: theme.textTheme.headline6.copyWith(
            color: Consts.horaColor[totais.tipo],
          ),
        ),
        subtitle: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Minutos: ${totais.minutos}", style: theme.textTheme.subtitle1),
              Text("Total: ${totais.total}", style: theme.textTheme.subtitle1),
            ],
          ),
        ),
        trailing: Text(
          "${totais.porcentagem} %",
          style: theme.textTheme.subtitle2,
        ),
      ),
    );
  }
}
