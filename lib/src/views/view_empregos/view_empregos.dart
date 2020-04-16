import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_emprego.dart';
import 'package:marcaii_flutter/src/utils/form_view.dart';
import 'package:marcaii_flutter/src/views/shared/appbar_save_button.dart';
import 'package:marcaii_flutter/src/views/view_empregos/widgets/fechamento_tile.dart';
import 'package:marcaii_flutter/src/views/view_empregos/widgets/porcentagens/porcentagens.dart';
import 'package:marcaii_flutter/src/views/view_empregos/widgets/salario_tile.dart';
import 'package:marcaii_flutter/src/views/view_empregos/widgets/salarios_list_tile/salarios_list_tile.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:provider/provider.dart';

import 'view_empregos_widgets.dart';

class ViewEmpregos extends StatefulWidget {
  @override
  _ViewEmpregosState createState() => _ViewEmpregosState();
}

class _ViewEmpregosState extends State<ViewEmpregos> with WillPopForm {
  GlobalKey<FormState> _formKey;
  BlocEmprego blocEmpregos;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    blocEmpregos = Provider.of<BlocEmprego>(context);

    return WillPopScope(
      onWillPop: () => willPop(
        context: context,
        formState: _formKey.currentState,
        hasChanged: blocEmpregos.didChange(),
        isCreating: blocEmpregos.isCreating,
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 4,
          title: const Text(Strings.empregos),
          actions: <Widget>[
            AppbarSaveButton(
              // onPressed: doSave,
              onPressed: () {
                final result = blocEmpregos.provideResult();
                result.salarios.forEach(print);
                doSave(
                  context: context,
                  formState: _formKey.currentState,
                  resultData: result,
                );
              },
            )
          ],
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const NomeEmpregoTile(),              
              const Divider(indent: 64,),
              const ViewPorcentagens(),
              const CargaHorariaTile(),
              const FechamentoTile(),
              const Divider(indent: 64,),
              const HorarioSaidaTile(),
              const Divider(indent: 64,),
              const EmpregoAtivoTile(),
              const Divider(indent: 64,),
              const BancoHorasTile(),
              blocEmpregos.isCreating ? SalarioTile() : const SalariosListTile(),
              const ListDiferenciadas(),
            ],
          ),
        ),        
      ),
    );
  }
}
