import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_emprego.dart';
import 'package:marcaii_flutter/src/views/widgets/config_tiles/switch_tile.dart';
import 'package:marcaii_flutter/strings.dart';

class BancoHorasTile extends StatelessWidget {
  const BancoHorasTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final b = Get.find<BlocEmprego>();
    return StreamObserver<bool>(
      stream: b.bancoHoras,
      onAwaiting: (_) => Container(),
      onSuccess: (_, bancoHoras) {
        return SwitchTile(
          initialValue: bancoHoras,
          icon: Icon(
            LineAwesomeIcons.life_saver,
            color: Colors.teal,
          ),
          label: Strings.bancoHoras,
          onChanged: b.setBancoHora,
        );
      },
    );
  }
}
