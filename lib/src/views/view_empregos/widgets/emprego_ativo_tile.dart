import 'package:flutter/material.dart';
import 'package:flutter_utils/async_widgets/stream_observer.dart';
import 'package:flutter_utils/config_tiles/config_tiles.dart';
import 'package:get/get.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_emprego.dart';
import 'package:marcaii_flutter/strings.dart';

class EmpregoAtivoTile extends StatelessWidget {
  const EmpregoAtivoTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final b = Get.find<BlocEmprego>();
    return StreamObserver<bool>(
      stream: b.ativo,
      onAwaiting: (_) => Container(),
      onSuccess: (_, ativo) => SwitchTile(
        icon: const Icon(
          LineAwesomeIcons.asterisk,
          color: Colors.red,
        ),
        initialValue: ativo,
        label: Strings.atual,
        onChanged: b.setAtivo,
      ),
    );
  }
}
