import 'package:card_settings/card_settings.dart';
import 'package:card_settings/widgets/card_settings_panel.dart';
import 'package:flutter/material.dart';
import 'package:marcaii_flutter/strings.dart';

class ViewDiferenciada extends StatefulWidget {
  const ViewDiferenciada({Key key, this.weekday, this.percent}) : super(key: key);
  final int weekday, percent;

  @override
  _ViewDiferenciadaState createState() => _ViewDiferenciadaState();
}

class _ViewDiferenciadaState extends State<ViewDiferenciada> {
  int _percent;

  @override
  void initState() {
    _percent = widget.percent;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.diferenciada),
      ),
      body: CardSettings(
        labelWidth: 250,
        shrinkWrap: true,
        children: <Widget>[
          CardSettingsNumberPicker(
            
            icon: Icon(Icons.confirmation_number),
            label: Strings.porcentagem,
            initialValue: _percent,
            min: 100,
            max: 999,
            onChanged: (p) => setState(() => _percent = p),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Salvar"),
        icon: Icon(Icons.save),
        onPressed: () {
          Navigator.of(context).pop(
            {"weekDay": widget.weekday, "percent": _percent},
          );
        },
      ),
    );
  }
}
