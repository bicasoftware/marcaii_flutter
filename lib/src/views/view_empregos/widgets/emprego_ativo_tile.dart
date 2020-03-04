import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_emprego.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:provider/provider.dart';
import 'package:marcaii_flutter/src/views/shared/config_tiles/switch_tile.dart';

class EmpregoAtivoTile extends StatelessWidget {
  const EmpregoAtivoTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocEmprego>(context);
    return StreamObserver<bool>(
      stream: b.ativo,
      onAwaiting: (_) => Container(),
      onSuccess: (_, ativo) => SwitchTile(
        icon: Icon(
          Icons.favorite,
          color: Colors.red,
        ),
        initialValue: ativo,
        label: Strings.atual,
        onChanged: b.setAtivo,
      ),
    );
  }
}
