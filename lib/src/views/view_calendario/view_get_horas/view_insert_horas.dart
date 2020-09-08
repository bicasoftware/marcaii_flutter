import 'package:flutter/material.dart';
import 'package:flutter_utils/config_tiles/config_tiles.dart';
import 'package:flutter_utils/flutter_utils.dart';
import 'package:marcaii_flutter/context_helper.dart';
import 'package:marcaii_flutter/src/utils/helpers/time_helper.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/src/views/widgets/appbar_save_button.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:marcaii_flutter/src/utils/helpers/date_helper.dart';
import 'package:marcaii_flutter/src/utils/helpers/empregos_helper.dart';

class ViewInsertHoras extends StatefulWidget {
  const ViewInsertHoras({Key key, this.emprego, this.data}) : super(key: key);
  final DateTime data;
  final Empregos emprego;

  @override
  _ViewInsertHorasState createState() => _ViewInsertHorasState();
}

class _ViewInsertHorasState extends State<ViewInsertHoras> {
  bool hasChanged;
  TimeOfDay inicio, termino;
  int tipo;

  @override
  void initState() {
    inicio = widget.emprego.horaSaida;
    termino = inicio.addHour(1);
    tipo = 0;
    hasChanged = false;
    super.initState();
  }

  void setInicio(TimeOfDay inicio) {
    setState(() => this.inicio = inicio);
    hasChanged = true;
  }

  void setTermino(TimeOfDay termino) {
    setState(() => this.termino = termino);
    hasChanged = true;
  }

  void setTipo(int newTipo) {
    setState(() => tipo = newTipo);
    hasChanged = true;
  }

  int get diferenciada {
    final p = widget.emprego.diferenciadas.firstWhere(
      (h) => h.weekday == widget.data.indexWeekday(),
      orElse: () => null,
    );

    return p?.porc ?? -1;
  }

  void showErrorMessage(BuildContext ctx, String error) {
    Scaffold.of(ctx).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(ctx).accentColor,
        duration: const Duration(seconds: 5),
        content: Text(error),
      ),
    );
  }

  Future<bool> canPop(BuildContext context) async {
    if (hasChanged) {
      final result = await Dialogs.showConfirmationDialog(
        context: context,
      );

      return result ?? true;
    }

    return true;
  }

  void onSave(BuildContext context) {
    context.goBack(
      Horas(
        emprego_id: widget.emprego.id,
        inicio: inicio.toShortString(),
        termino: termino.toShortString(),
        tipo: tipo,
        data: widget.data,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final horasTipo = {
      0: const Text("Normal"),
      1: const Text("Completa"),
      if (diferenciada > -1) 2: const Text("Diferenciada"),
    };

    return WillPopScope(
      onWillPop: () => canPop(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(Strings.novaHorasExtra),
          actions: <Widget>[
            AppbarSaveButton(
              onPressed: () {
                onSave(context);
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                /* TimePickerTile(
                  icon: const Icon(
                    LineAwesomeIcons.clock_o,
                    color: Colors.amber,
                  ),
                  initialTime: inicio,
                  label: Strings.inicio,
                  onTimeSet: setInicio,
                ),
                const Divider(),
                TimePickerTile(
                  icon: const Icon(
                    LineAwesomeIcons.clock_o,
                    color: Colors.pink,
                  ),
                  initialTime: termino,
                  label: Strings.saida,
                  onTimeSet: setTermino,
                ), */
                TimeTile(
                  beginLabel: Strings.inicio,
                  endLabel: Strings.termino,
                  initialTime: inicio,
                  onSaved: setInicio,
                ),
                TimeTile(
                  beginLabel: Strings.inicio,
                  endLabel: Strings.termino,
                  initialTime: termino,
                  onSaved: setTermino,
                ),
                const Divider(),
                MultiOptionControll(
                  label: Strings.tipoHora,
                  children: horasTipo,
                  initValue: tipo,
                  selectedColor: Consts.horaColor[tipo],
                  borderColor: context.theme.dividerColor,
                  onValueChanged: (b) => setState(() => tipo = b),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
