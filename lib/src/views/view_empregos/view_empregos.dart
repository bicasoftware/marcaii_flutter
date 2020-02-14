import 'package:card_settings/widgets/card_settings_field.dart';
import 'package:card_settings/widgets/card_settings_panel.dart';
import 'package:card_settings/widgets/information_fields/card_settings_header.dart';
import 'package:card_settings/widgets/numeric_fields/card_settings_switch.dart';
import 'package:card_settings/widgets/picker_fields/card_settings_list_picker.dart';
import 'package:card_settings/widgets/picker_fields/card_settings_number_picker.dart';
import 'package:card_settings/widgets/picker_fields/card_settings_time_picker.dart';
import 'package:card_settings/widgets/text_fields/card_settings_text.dart';
import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/views/view_diferenciada/view_diferenciada.dart';
import 'package:marcaii_flutter/strings.dart';

class ViewEmpregos extends StatelessWidget {
  final txtDesc = TextEditingController(text: "Emprego");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.empregos),
      ),
      body: CardSettings(
        cardElevation: 2,
        shrinkWrap: true,
        contentAlign: TextAlign.end,
        labelAlign: TextAlign.start,
        labelWidth: 180,
        children: <Widget>[
          CardSettingsHeader(label: "Informações Básicas"),
          CardSettingsText(
            controller: txtDesc,
            icon: Icon(Icons.person),
            label: "Domingo",
            hintText: "Estoquista",
          ),
          CardSettingsNumberPicker(
            icon: Icon(Icons.confirmation_number),
            label: Strings.porc,
            initialValue: 50,
            min: 50,
            max: 999,
          ),
          CardSettingsNumberPicker(
            icon: Icon(Icons.confirmation_number),
            label: Strings.porcCompleta,
            initialValue: 100,
            min: 100,
            max: 999,
          ),
          CardSettingsListPicker(
            icon: Icon(Icons.timelapse),
            label: Strings.cargaHoraria,
            initialValue: "220",
            options: Consts.CargasHoraria.map(
              (i) => i.toString(),
            ).toList(),
          ),
          CardSettingsTimePicker(
            initialValue: const TimeOfDay(hour: 18, minute: 0),
            icon: Icon(Icons.timer),
            label: Strings.saida,
            onChanged: (t) {
              //TODO - implementar
            },
          ),
          CardSettingsSwitch(
            icon: Icon(Icons.share),
            initialValue: true,
            label: Strings.bancoHoras,
            falseLabel: "Não",
            trueLabel: "Sim",
            onChanged: (b) {
              //TODO - implementar
            },
          ),
          CardSettingsSwitch(
            icon: Icon(Icons.info),
            initialValue: true,
            label: Strings.atual,
            falseLabel: "Não",
            trueLabel: "Sim",
            onChanged: (b) {
              //TODO - implementar
            },
          ),
          CardSettingsHeader(label: "Horas diferenciadas"),
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
                      print(result);
                    }
                  },
                )
            ],
          )
        ],
      ),
    );
  }
}
