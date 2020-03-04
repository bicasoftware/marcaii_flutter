import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:marcaii_flutter/src/database/models/diferenciadas.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_emprego.dart';
import 'package:marcaii_flutter/src/views/shared/config_tiles/base_config_tile.dart';
import 'package:marcaii_flutter/src/views/shared/list_separator.dart';
import 'package:marcaii_flutter/src/views/view_empregos/diferenciada/view_diferenciada.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:provider/provider.dart';

class ListDiferenciadas extends StatelessWidget {
  const ListDiferenciadas({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocEmprego>(context);

    return MergedStreamObserver(
      streams: [b.bancoHoras, b.outDiferenciadas],
      onSuccess: (_, List<Object> streamResult) {
        final bancoHoras = streamResult[0] as bool;
        final List<Diferenciadas> diferenciadas = streamResult[1] as List<Diferenciadas>;
        if (!bancoHoras) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListSeparator(label: Strings.diferenciadas),
              for (Diferenciadas dif in diferenciadas)
                BaseConfigTile(
                  trailingWidth: 30,
                  label: Consts.weekDayExtenso[dif.weekday],
                  icon: Icon(
                    Icons.date_range,
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
