import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marcaii_flutter/src/database/models/diferenciadas.dart';
import 'package:marcaii_flutter/src/utils/dialogs/dialogs.dart';
import 'package:marcaii_flutter/src/views/shared/appbar_save_button.dart';
import 'package:marcaii_flutter/src/views/shared/config_tiles/text_tile.dart';
import 'package:marcaii_flutter/src/views/view_empregos/emprego_validate.dart';
import 'package:marcaii_flutter/strings.dart';

class ViewDiferenciada extends StatefulWidget {
  const ViewDiferenciada({Key key, this.diferenciada}) : super(key: key);
  final Diferenciadas diferenciada;

  @override
  _ViewDiferenciadaState createState() => _ViewDiferenciadaState();
}

class _ViewDiferenciadaState extends State<ViewDiferenciada> {
  Diferenciadas _diferenciada;
  GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _diferenciada = widget.diferenciada;
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.diferenciadas),
        actions: <Widget>[
          AppbarSaveButton(
            onPressed: () {
              final formState = _formKey.currentState;
              if (formState.validate()) {
                formState.save();
                Navigator.of(context).pop(_diferenciada);
              }
            },
          ),
          IconButton(
            icon: Icon(
              Icons.delete_sweep,
              color: Colors.orange,
            ),
            onPressed: () async {
              final result = await showCanCloseDialog(
                context: context,
                title: "Aviso - Remoção",
                message: "Deseja remover o valor diferenciado?",
              );

              if (result != null && result) {
                Navigator.of(context).pop(_diferenciada.copyWith(porc: 0));
              }
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: TextTile(
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3),
            ],
            trailingWidth: 32,
            initialValue: _diferenciada.porc.toString(),
            label: Strings.porcentagem,
            hint: "100",
            inputType: TextInputType.number,
            icon: Icon(
              Icons.date_range,
              color: Colors.red,
            ),
            onChanged: (String value) {
              _diferenciada = _diferenciada.copyWith(porc: int.tryParse(value));
            },
            validator: (String s) {
              return EmpregoValidate.validatePorc(s, 50);
            },
          ),
        ),
      ),
    );
  }
}
