import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:marcaii_flutter/src/database/models/diferenciadas.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_emprego.dart';
import 'package:marcaii_flutter/src/views/shared/config_tiles/base_config_tile.dart';
import 'package:marcaii_flutter/src/views/view_diferenciada/view_diferenciada.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:provider/provider.dart';

class ViewEmpregoDiferenciadas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocEmprego>(context);
    final theme = Theme.of(context);

    return MergedStreamObserver(
      streams: [b.bancoHoras, b.outDiferenciadas],
      onSuccess: (_, List<Object> streamResult) {
        final bancoHoras = streamResult[0] as bool;
        final List<Diferenciadas> diferenciadas = streamResult[1] as List<Diferenciadas>;
        if (!bancoHoras) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Divider(),
                    Text(
                      Strings.diferenciadas,
                      style: theme.textTheme.caption.copyWith(color: theme.accentColor),
                    )
                  ],
                ),
              ),
              for (Diferenciadas dif in diferenciadas)
                BaseConfigTile(
                  trailingWidth: 30,
                  label: Consts.weekDayExtenso[dif.weekday],
                  icon: Icon(
                    FontAwesomeIcons.calendarWeek,
                    color: Consts.weekdayColors[dif.weekday],
                  ),
                  trailing: Text("${dif.porc}"),
                  onTap: () async {
                    final result = await Navigator.of(context).push(
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (_) => ViewDiferenciada(diferenciada: dif),
                      ),
                    );

                    if (result != null && result is Diferenciadas) {
                      b.setDiferenciada(dif, result.porc);
                    }
                  },
                ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
