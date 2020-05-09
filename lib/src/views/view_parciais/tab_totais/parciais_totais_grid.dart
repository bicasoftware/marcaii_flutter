import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/state/totais_domain/totais_item.dart';
import 'package:marcaii_flutter/src/utils/bottom_indicator_container.dart';
import 'package:marcaii_flutter/strings.dart';

class ParciaisTotalGrid extends StatelessWidget {
  const ParciaisTotalGrid({Key key, this.totais}) : super(key: key);

  final List<TotaisItem> totais;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: <Widget>[
        for (final t in totais) _ParciaisTotaisGridItem(total: t)
      ],
    );
  }
}

class _ParciaisTotaisGridItem extends StatelessWidget {
  const _ParciaisTotaisGridItem({Key key, this.total}) : super(key: key);

  final TotaisItem total;

  String get label {
    switch (total.tipo) {
      case 0:
        return Strings.normais;
        break;
      case 1:
        return Strings.feriados;
        break;
      case 2:
        return Consts.weekDayExtenso[total.weekday];
        break;
      case 3:
        return Strings.totais;
        break;
      default:
        return "";
        break;
    }
  }

  Color get color => Consts.horaColor[total.tipo];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BottomIndicatorContainer(
      elevation: .2,
      indicatorColor: Consts.horaColor[total.tipo],
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          AutoSizeText(
            label,
            maxLines: 1,
            softWrap: true,
            minFontSize: 8,
            style: theme.textTheme.subtitle2.copyWith(
              color: Consts.horaColor[total.tipo],
            ),
          ),
          const Divider(indent: 8, endIndent: 8),
        ],
      ),
    );
  }
}
