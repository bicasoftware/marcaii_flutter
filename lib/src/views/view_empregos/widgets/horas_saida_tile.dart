import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_emprego.dart';
import 'package:marcaii_flutter/src/utils/helpers/time_helper.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:provider/provider.dart';
import 'package:marcaii_flutter/src/views/widgets/config_tiles/time_tile.dart';

class HorarioSaidaTile extends StatelessWidget {
  const HorarioSaidaTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocEmprego>(context);
    return StreamObserver<String>(
      stream: b.saida,
      onAwaiting: (_) => Container(),
      onSuccess: (_, saida) => TimePickerTile(
        icon: Icon(
          LineAwesomeIcons.sign_out,
          color: Colors.pink,
        ),
        initialTime: stringToTimeOfDay(saida),
        label: Strings.saida,
        onTimeSet: b.setSaida,
      ),
    );
  }
}