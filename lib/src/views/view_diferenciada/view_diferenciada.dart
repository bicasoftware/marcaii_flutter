import 'package:card_settings/card_settings.dart';
import 'package:card_settings/widgets/card_settings_panel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marcaii_flutter/src/views/shared/config_tiles/drop_down_tile.dart';
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
    return SafeArea(            
      //TODO - Testar safeArea
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(8),
          child: DropdownTile<int>(
            icon: Icon(
              FontAwesomeIcons.percentage,
              color: Consts.horaColor.first,
            ),
            label: Strings.porcDifer,
            initialValue: _percent,
            items: [for (int i = 50; i <= 300; i++) i],
            formatter: (int i) => "$i %",
            onChanged: (p) {
              setState(() => _percent = p);
            },
          ),
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
      ),
    );
  }
}
