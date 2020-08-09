import 'package:flutter/material.dart';
import 'package:flutter_utils/async_widgets/stream_observer.dart';
import 'package:flutter_utils/config_tiles/time_tile.dart';
import 'package:get/get.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_emprego.dart';
import 'package:marcaii_flutter/src/utils/helpers/time_helper.dart';
import 'package:marcaii_flutter/strings.dart';

class HorarioSaidaTile extends StatelessWidget {
  const HorarioSaidaTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final b = Get.find<BlocEmprego>();
    return StreamObserver<String>(
      stream: b.saida,
      onAwaiting: (_) => Container(),
      onSuccess: (_, saida) => TimePickerTile(
        icon: const Icon(
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
