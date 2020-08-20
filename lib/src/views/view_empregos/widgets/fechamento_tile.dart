import 'package:flutter/material.dart';
import 'package:flutter_utils/async_widgets/stream_observer.dart';
import 'package:flutter_utils/config_tiles/config_tiles.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_emprego.dart';
import 'package:marcaii_flutter/src/views/widgets/dialogs.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:provider/provider.dart';

class FechamentoTile extends StatelessWidget {
  const FechamentoTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocEmprego>(context);

    return StreamObserver<int>(
      stream: b.fechamento,
      onSuccess: (BuildContext context, int dia) {
        return BaseConfigTile(
          label: Strings.fechamento,
          trailing: Text(
            dia.toString(),
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          trailingWidth: 30,
          icon: const Icon(
            LineAwesomeIcons.calendar,
            color: Colors.pink,
          ),
          onTap: () async {
            final r = await showFechamentoPicker(
              context: context,
              fechamento: dia,
            );

            if (r != null && r is int) {
              b.setFechamento(r);
            }
          },
        );
      },
    );
  }
}
