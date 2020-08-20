import 'package:flutter/material.dart';
import 'package:flutter_utils/async_widgets/async_widget.dart';
import 'package:flutter_utils/config_tiles/config_tiles.dart';
import 'package:marcaii_flutter/context_helper.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_emprego.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:provider/provider.dart';

class CargaHorariaTile extends StatelessWidget {
  const CargaHorariaTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocEmprego>(context);
    return StreamObserver<int>(
      stream: b.cargaHoraria,
      onAwaiting: (_) => Container(),
      onSuccess: (_, int carga) {
        return MultiOptionControll(
          label: Strings.cargaHoraria,
          initValue: carga,
          selectedColor: context.theme.accentColor,
          onValueChanged: b.setCargaHoraria,
          borderColor: context.theme.accentColor,
          children: Maps.cargaHoraria,
        );
      },
    );
  }
}
