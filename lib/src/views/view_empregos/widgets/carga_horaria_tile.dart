import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_emprego.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:provider/provider.dart';
import 'package:marcaii_flutter/src/views/shared/config_tiles/drop_down_tile.dart';

class CargaHorariaTile extends StatelessWidget {
  const CargaHorariaTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocEmprego>(context);
    return StreamObserver<int>(
      stream: b.cargaHoraria,
      onAwaiting: (_) => Container(),
      onSuccess: (_, carga) {
        return DropdownTile<int>(
          icon: Icon(
            LineAwesomeIcons.clock_o,
            color: Colors.orange,
          ),
          label: Strings.cargaHoraria,
          initialValue: carga,
          items: <int>[for (final c in Consts.cargasHoraria) c],
          onChanged: b.setCargaHoraria,
          trailingWidth: 60,
        );
      },
    );
  }
}