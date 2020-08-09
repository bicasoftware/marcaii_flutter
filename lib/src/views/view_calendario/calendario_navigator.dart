import 'package:flutter/material.dart';
import 'package:flutter_utils/async_widgets/async_widget.dart';
import 'package:get/get.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_main.dart';
import 'package:marcaii_flutter/src/utils/vigencia.dart';
import 'package:marcaii_flutter/src/views/widgets/dialogs.dart';

class CalendarioNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final b = Get.find<BlocMain>();
    return Container(
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          IconButton(
            icon: const Icon(LineAwesomeIcons.angle_left),
            onPressed: b.decMes,
          ),
          StreamObserver<Vigencia>(
            stream: b.outVigencia,
            onSuccess: (_, vig) => Expanded(
              child: FlatButton.icon(
                icon: const Icon(LineAwesomeIcons.calendar_o),
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
            icon: const Icon(LineAwesomeIcons.angle_right),
            onPressed: b.incMes,
          ),
        ],
      ),
    );
  }
}
