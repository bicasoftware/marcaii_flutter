import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/src/utils/dialogs/dialogs.dart';
import 'package:marcaii_flutter/src/views/shared/config_tiles/time_tile.dart';
import 'package:marcaii_flutter/src/views/shared/appbar_save_button.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:marcaii_flutter/helpers.dart';

class ViewInsertHoras extends StatefulWidget {
  const ViewInsertHoras({Key key, this.emprego, this.data}) : super(key: key);
  final DateTime data;
  final Empregos emprego;

  @override
  _ViewInsertHorasState createState() => _ViewInsertHorasState();
}

class _ViewInsertHorasState extends State<ViewInsertHoras> {
  TimeOfDay inicio, termino;
  int tipo;

  

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
    if (inicio == termino) {
      showErrorMessage(context, Validations.horariosIguais);
    } else if (!inicio.isBefore(termino)) {
      showErrorMessage(context, Validations.horarioInvalido);
    } else {
      final result = await showCanCloseDialog(
        context: context,
      );

      return result ?? true;
    }

    return false;
  }

  void onSave() {
    Navigator.of(context).pop(
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
    return WillPopScope(
      onWillPop: () => canPop(context),
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            AppbarSaveButton(
              onPressed: onSave,
            )
          ],
        ),
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            TimePickerTile(
              icon: Icon(
                Icons.timer,
                color: Colors.amber,
              ),
              initialTime: inicio,
              label: Strings.inicio,
              onTimeSet: (t) => setState(() => inicio = t),
            ),
            TimePickerTile(
              icon: Icon(
                Icons.timer,
                color: Colors.pink,
              ),
              initialTime: inicio,
              label: Strings.saida,
              onTimeSet: (t) => setState(() => termino = t),
            ),
            RadioListTile<int>(
              groupValue: 0,
              value: tipo,
              title: Text(Strings.horaNormal),
              subtitle: Text("${widget.emprego.porc} %"),
              onChanged: (b) => setState(() => tipo = 0),
            ),
            RadioListTile<int>(
              groupValue: 1,
              value: tipo,
              title: Text(Strings.horaCompleta),
              subtitle: Text("${widget.emprego.porc_completa} %"),
              onChanged: (b) => setState(() => tipo = 1),
            ),
            if (diferenciada > -1)
              RadioListTile<int>(
                groupValue: 2,
                value: tipo,
                title: Text(Strings.horaCompleta),
                subtitle: Text("${diferenciada} %"),
                onChanged: (b) => setState(() => tipo = 2),
              ),
          ],
        ),
      ),
    );
  }
}