import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:marcaii_flutter/helpers.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_main.dart';
import 'package:marcaii_flutter/src/state/calendario_item.dart';
import 'package:marcaii_flutter/src/utils/vigencia.dart';
import 'package:marcaii_flutter/src/views/view_calendario/calendario/calendario_item_empty.dart';
import 'package:marcaii_flutter/src/views/view_calendario/calendario_item.dart';
import 'package:provider/provider.dart';

class CalendarioPage extends StatelessWidget {
  const CalendarioPage({
    @required this.emprego,
    @required this.onItemTap,
    Key key,
  }) : super(key: key);

  final Empregos emprego;
  final Function(CalendarioChild child) onItemTap;

  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocMain>(context);
    final today = DateTime.now();

    return StreamObserver<Vigencia>(
      stream: b.outVigencia,
      onSuccess: (_, Vigencia vigencia) {
        final calendario = emprego.getCalendario(vigencia.vigencia);
        return Padding(
          padding: const EdgeInsets.all(8.0),
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
                  onTap: onItemTap,
                );
              }),
              ...CalendarioEmptyCells.atEnd(lastDate: calendario.items.last.date)
            ],
          ),
        );
      },
    );
  }
}
/* class CalendarioPage extends StatefulWidget {
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

class _CalendarioPageState extends State<CalendarioPage> {
  DateTime today;

  @override
  void initState() {
    today = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocMain>(context);

    return StreamObserver<Vigencia>(
      stream: b.outVigencia,
      onSuccess: (_, Vigencia vigencia) {
        final calendario = widget.emprego.getCalendario(vigencia.vigencia);
        return Padding(
          padding: const EdgeInsets.all(8.0),
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
                  onTap: widget.onItemTap(calendario.items[i]),
                );
              }),
              ...CalendarioEmptyCells.atEnd(lastDate: calendario.items.last.date)
            ],
          ),
        );
      },
    );
  }
}
 */
