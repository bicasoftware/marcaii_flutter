import 'package:flutter/material.dart';
import 'package:flutter_utils/async_widgets/async_widget.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_main.dart';
import 'package:marcaii_flutter/src/utils/vigencia.dart';
import 'package:marcaii_flutter/src/views/widgets/dialogs.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:provider/provider.dart';

class CalendarioNavigator extends StatefulWidget {
  @override
  _CalendarioNavigatorState createState() => _CalendarioNavigatorState();
}

class _CalendarioNavigatorState extends State<CalendarioNavigator>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  String _oldVigencia;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Consts.animationDuration,
      vsync: this,
    );

    _oldVigencia = "";
  }

  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocMain>(context);
    return Container(
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          IconButton(
            icon: const Icon(LineAwesomeIcons.angle_left),
            onPressed: b.decMes,
          ),
          Expanded(
            child: FadeTransition(
              opacity: controller,
              child: StreamObserver<Vigencia>(
                stream: b.outVigencia,
                onSuccess: (_, vig) {
                  if (_oldVigencia != vig.value) {
                    controller.reset();
                    controller.forward();
                  }

                  _oldVigencia = vig.value;
                  return FlatButton.icon(
                    icon: const Icon(LineAwesomeIcons.calendar_o),
                    label: Text(
                      vig.fullValue,
                      style:
                          Theme.of(context).textTheme.button.copyWith(fontStyle: FontStyle.italic),
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
                  );
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
