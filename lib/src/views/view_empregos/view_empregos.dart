import 'package:card_settings/widgets/card_settings_panel.dart';
import 'package:card_settings/widgets/information_fields/card_settings_header.dart';
import 'package:card_settings/widgets/numeric_fields/card_settings_switch.dart';
import 'package:card_settings/widgets/picker_fields/card_settings_list_picker.dart';
import 'package:card_settings/widgets/picker_fields/card_settings_number_picker.dart';
import 'package:card_settings/widgets/picker_fields/card_settings_time_picker.dart';
import 'package:card_settings/widgets/text_fields/card_settings_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/utils/helpers/time_helper.dart';
import 'package:marcaii_flutter/src/views/shared/config_tiles/drop_down_tile.dart';
import 'package:marcaii_flutter/src/views/shared/config_tiles/switch_tile.dart';
import 'package:marcaii_flutter/src/views/shared/config_tiles/text_tile.dart';
import 'package:marcaii_flutter/src/views/shared/config_tiles/time_tile.dart';
import 'package:marcaii_flutter/src/views/view_diferenciada/view_diferenciada.dart';
import 'package:marcaii_flutter/strings.dart';

class ViewEmpregos extends StatefulWidget {
  const ViewEmpregos({
    @required this.emprego,
    Key key,
  }) : super(key: key);
  final Empregos emprego;

  @override
  _ViewEmpregosState createState() => _ViewEmpregosState();
}

class _ViewEmpregosState extends State<ViewEmpregos> {
  TextEditingController txtDesc;
  Empregos _emprego;

  @override
  void initState() {
    _emprego = widget.emprego.copyWith();
    txtDesc = TextEditingController(text: _emprego.nome);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_emprego.nome),
        actions: <Widget>[
          FlatButton(
            child: Text(
              Strings.salvar,
              style: theme.textTheme.subhead,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          TextTile(
            icon: Icon(
              LineAwesomeIcons.file_text_o,
              color: Colors.lightBlue,
            ),
            label: Strings.descricao,
            controller: txtDesc,
            hint: "Emprego 1",
          ),
          DropdownTile<int>(
            icon: Icon(
              FontAwesomeIcons.percentage,
              color: Consts.horaColor.first,
            ),
            label: Strings.porc,
            initialValue: _emprego.porc,
            items: [for (int i = 50; i <= 300; i++) i],
            formatter: (int i) => "$i %",
            onChanged: (p) {
              setState(() {
                _emprego = _emprego.copyWith(porc: p);
              });
            },
          ),
          DropdownTile<int>(
            icon: Icon(
              FontAwesomeIcons.percentage,
              color: Consts.horaColor[1],
            ),
            label: Strings.porcCompleta,
            initialValue: _emprego.porc_completa,
            items: [for (int i = 100; i <= 300; i++) i],
            formatter: (int i) => "$i %",
            onChanged: (p) {
              setState(() {
                _emprego = _emprego.copyWith(porc: p);
              });
            },
          ),
          DropdownTile<int>(
            icon: Icon(
              FontAwesomeIcons.clock,
              color: Colors.orange,
            ),
            label: Strings.cargaHoraria,
            initialValue: _emprego.carga_horaria,
            items: <int>[for (final c in Consts.cargasHoraria) c],
            onChanged: (int value) {
              setState(() {
                _emprego = _emprego.copyWith(carga_horaria: value);
              });
            },
          ),
          TimePickerTile(
            icon: Icon(
              FontAwesomeIcons.businessTime,
              color: Colors.pink,
            ),
            initialTime: stringToTimeOfDay(_emprego.saida),
            label: Strings.saida,
            onTimeSet: (time) {
              setState(() => _emprego = _emprego.copyWith(saida: time.toShortString()));
            },
          ),
          SwitchTile(
            initialValue: _emprego.banco_horas,
            icon: Icon(
              Icons.offline_pin,
              color: Colors.teal,
            ),
            label: Strings.bancoHoras,
            onChanged: (b) {
              setState(() => _emprego = _emprego.copyWith(banco_horas: b));
            },
          ),
          SwitchTile(
            icon: Icon(
              FontAwesomeIcons.envira,
              color: Colors.red,
            ),
            initialValue: _emprego.ativo,
            label: Strings.atual,
            onChanged: (b) {
              setState(() => _emprego = _emprego.copyWith(ativo: b));
            },
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Divider(),
                Text(Strings.diferenciadas,
                    style: theme.textTheme.caption.copyWith(
                      color: theme.accentColor,
                    ))
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              for (int i = 0; i < Consts.weekDayExtenso.length; i++)
                ListTile(
                  title: Text(Consts.weekDayExtenso[i]),
                  leading: Icon(Icons.weekend),
                  onTap: () async {
                    final result = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ViewDiferenciada(percent: 110, weekday: i),
                      ),
                    );

                    if (result != null && result is Map<String, dynamic>) {
                      //TODO - Aplicar diferenciada aqui
                      print(result);
                    }
                  },
                )
            ],
          ),
        ],
      ),
    );
  }
}
