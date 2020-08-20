import 'package:flutter/material.dart';
import 'package:flutter_utils/async_widgets/async_widget.dart';
import 'package:flutter_utils/config_tiles/config_tiles.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_emprego.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:provider/provider.dart';

class BancoHorasTile extends StatelessWidget {
  const BancoHorasTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocEmprego>(context);
    return StreamObserver<bool>(
      stream: b.bancoHoras,
      onAwaiting: (_) => Container(),
      onSuccess: (_, bancoHoras) {
        return SwitchTile(
          initialValue: bancoHoras,
          icon: const Icon(
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
