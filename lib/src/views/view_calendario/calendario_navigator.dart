import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_main.dart';
import 'package:marcaii_flutter/src/utils/vigencia.dart';
import 'package:marcaii_flutter/src/views/widgets/dialogs.dart';
import 'package:provider/provider.dart';

class CalendarioNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocMain>(context);
    return Container(
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          IconButton(
            icon: Icon(LineAwesomeIcons.angle_left),
            onPressed: b.decMes,
          ),
          StreamObserver<Vigencia>(
            stream: b.outVigencia,
            onSuccess: (_, vig) => Expanded(
              child: FlatButton.icon(
                icon: Icon(LineAwesomeIcons.calendar_o),
                label: Text(
                  vig.vigenciaExtenso,
                  style: Theme.of(context).textTheme.button.copyWith(fontStyle: FontStyle.italic),
                ),
                onPressed: () async {
                  final r = await showVigenciaPicker(
                    context: context,
                    vigencia: vig,
                  );

                  if (r != null && r is Vigencia) {
                    b.setVigencia(r);
                  }
                },
              ),
            ),
          ),
          IconButton(
            icon: Icon(LineAwesomeIcons.angle_right),
            onPressed: b.incMes,
          ),
        ],
      ),
    );
  }
}
