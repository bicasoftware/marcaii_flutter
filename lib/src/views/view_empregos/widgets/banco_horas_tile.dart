import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_emprego.dart';
import 'package:marcaii_flutter/src/views/shared/config_tiles/switch_tile.dart';
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
          icon: Icon(
            Icons.offline_pin,
            color: Colors.teal,
          ),
          label: Strings.bancoHoras,
          onChanged: b.setBancoHora,
        );
      },
    );
  }
}
