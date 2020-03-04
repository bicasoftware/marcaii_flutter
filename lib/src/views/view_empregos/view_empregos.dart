import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_emprego.dart';
import 'package:marcaii_flutter/src/utils/dialogs/dialogs.dart';
import 'package:marcaii_flutter/src/views/shared/appbar_save_button.dart';
import 'package:marcaii_flutter/src/views/view_empregos/widgets/fechamento_tile.dart';
import 'package:marcaii_flutter/src/views/view_empregos/widgets/salario_tile.dart';
import 'package:marcaii_flutter/src/views/view_empregos/widgets/salarios_list_tile/salarios_list_tile.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:provider/provider.dart';

import 'view_empregos_widgets.dart';

class ViewEmpregos extends StatefulWidget {
  @override
  _ViewEmpregosState createState() => _ViewEmpregosState();
}

class _ViewEmpregosState extends State<ViewEmpregos> {
  GlobalKey<FormState> _formKey;
  BlocEmprego blocEmpregos;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  void doSave() {
    final state = _formKey.currentState;
    if (state.validate()) {
      state.save();
      Navigator.of(context).pop(blocEmpregos.provideResult());
    }
  }

  Future<bool> _willPop() async {
    if (blocEmpregos.isCreating) {
      return true;
    } else if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (blocEmpregos.didChange()) {
        final r = await showCanCloseDialog(
          context: context,
          title: Strings.atencao,
          message: Strings.descartarAlteracoes,
          positiveCaption: Strings.descartar,
        );

        if (r != null && r) {
          Navigator.of(context).pop(blocEmpregos.provideResult());
        }
      } else {
        return true;
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    blocEmpregos = Provider.of<BlocEmprego>(context);

    return WillPopScope(
      onWillPop: _willPop,
      child: Scaffold(
        appBar: AppBar(
          elevation: 4,
          title: const Text(Strings.empregos),
          actions: <Widget>[
            AppbarSaveButton(
              onPressed: doSave,
            )
          ],
        ),
        body: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const NomeEmpregoTile(),
                  const FechamentoTile(),
                  const PorcNormalTile(),
                  const PorcCompletaTile(),
                  const CargaHorariaTile(),
                  const HorarioSaidaTile(),
                  const EmpregoAtivoTile(),
                  const BancoHorasTile(),
                  blocEmpregos.isCreating ? SalarioTile() : const SalariosListTile(),
                  const ListDiferenciadas(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
