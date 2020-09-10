import 'package:flutter/material.dart';
import 'package:flutter_utils/config_tiles/config_tiles.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:marcaii_flutter/context_helper.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/src/utils/helpers/date_helper.dart';
import 'package:marcaii_flutter/src/utils/helpers/empregos_helper.dart';
import 'package:marcaii_flutter/src/utils/helpers/time_helper.dart';
import 'package:marcaii_flutter/src/views/widgets/bottomsheeet_header.dart';
import 'package:marcaii_flutter/src/views/widgets/error_text_anim.dart';
import 'package:marcaii_flutter/src/views/widgets/light_container.dart';
import 'package:marcaii_flutter/strings.dart';

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
  bool hasError = false;

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

  void onSave(BuildContext context) {
    if (inicio.hour < termino.hour) {
      context.goBack(
        Horas(
          emprego_id: widget.emprego.id,
          inicio: inicio.toShortString(),
          termino: termino.toShortString(),
          tipo: tipo,
          data: widget.data,
        ),
      );
    } else {
      setState(() => hasError = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final horasTipo = {
      0: const Text("Normal"),
      1: const Text("Completa"),
      if (diferenciada > -1) 2: const Text("Diferenciada"),
    };

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          BottomsheetHeader(
            title: Strings.novaHorasExtra,
            icon: const Icon(Icons.save, color: Colors.lightGreen),
            onPressed: () => onSave(context),
            hasDivider: false,
          ),
          LightContainer(
            padding: EdgeInsets.zero,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: TimePickerTile(
              icon: const Icon(
                LineAwesomeIcons.clock_o,
                color: Colors.amber,
              ),
              initialTime: inicio,
              label: Strings.inicio,
              onTimeSet: setInicio,
            ),
          ),
          const SizedBox(height: 8),
          LightContainer(
            padding: EdgeInsets.zero,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: TimePickerTile(
              icon: const Icon(
                LineAwesomeIcons.clock_o,
                color: Colors.pink,
              ),
              initialTime: termino,
              label: Strings.saida,
              onTimeSet: setTermino,
            ),
          ),
          hasError
              ? Container(
                  width: double.maxFinite,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ErrorTextAnim(Validations.horaInvalida),
                  ),
                )
              : Container(),
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
    );
  }
}
