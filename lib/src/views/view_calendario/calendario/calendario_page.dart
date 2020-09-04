import 'package:flutter/material.dart';
import 'package:flutter_utils/async_widgets/async_widget.dart';
import 'package:marcaii_flutter/helpers.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_main.dart';
import 'package:marcaii_flutter/src/state/calendario/calendario_child.dart';
import 'package:marcaii_flutter/src/utils/vigencia.dart';
import 'package:marcaii_flutter/src/views/view_calendario/calendario/calendario_item.dart';
import 'package:marcaii_flutter/src/views/view_calendario/calendario/calendario_item_empty.dart';
import 'package:provider/provider.dart';

class CalendarioPage extends StatefulWidget {
  const CalendarioPage({
    @required this.emprego,
    @required this.onItemTap,
    Key key,
  }) : super(key: key);

  final Empregos emprego;
  final Function(CalendarioChild child) onItemTap;

  @override
  _CalendarioPageState createState() => _CalendarioPageState();
}

class _CalendarioPageState extends State<CalendarioPage> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> slide;
  String _oldVigencia;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    _oldVigencia = "";

    slide = Tween<Offset>(
      begin: const Offset(0.1, 0),
      end: Offset.zero,
    ).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocMain>(context);
    final today = DateTime.now();

    return SlideTransition(
      position: slide,
      child: FadeTransition(
        opacity: controller,
        child: StreamObserver<Vigencia>(
          stream: b.outVigencia,
          onSuccess: (_, Vigencia vigencia) {
            if (_oldVigencia != vigencia.vigencia) {
              controller.reset();
              controller.forward();
            }
            _oldVigencia = vigencia.vigencia;
            final calendario = widget.emprego.getCalendario(vigencia);
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: GridView.count(
                crossAxisCount: 7,
                shrinkWrap: true,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1.1,
                children: <Widget>[
                  ...CalendarioEmptyCells.atBegin(initialDate: calendario.items.first.date),
                  ...List.generate(calendario.items.length, (i) {
                    return CalendarioItem(
                      isToday: calendario.items[i].date.isSameDate(today),
                      childContent: calendario.items[i],
                      onTap: widget.onItemTap,
                    );
                  }),
                  ...CalendarioEmptyCells.atEnd(lastDate: calendario.items.last.date)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
