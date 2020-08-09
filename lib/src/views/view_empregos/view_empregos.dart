import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_utils/flutter_utils.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_emprego.dart';
import 'package:marcaii_flutter/src/views/view_empregos/widgets/banco_horas_tile.dart';
import 'package:marcaii_flutter/src/views/view_empregos/widgets/carga_horaria_tile.dart';
import 'package:marcaii_flutter/src/views/view_empregos/widgets/emprego_ativo_tile.dart';
import 'package:marcaii_flutter/src/views/view_empregos/widgets/fechamento_tile.dart';
import 'package:marcaii_flutter/src/views/view_empregos/widgets/horas_saida_tile.dart';
import 'package:marcaii_flutter/src/views/view_empregos/widgets/list_diferenciadas.dart';
import 'package:marcaii_flutter/src/views/view_empregos/widgets/nome_emprego_tile.dart';
import 'package:marcaii_flutter/src/views/view_empregos/widgets/porcentagens/porcentagens.dart';
import 'package:marcaii_flutter/src/views/view_empregos/widgets/view_emprego_salario_tile.dart';
import 'package:marcaii_flutter/src/views/view_empregos/widgets/salarios_list_tile/salarios_list_tile.dart';
import 'package:marcaii_flutter/src/views/widgets/appbar_save_button.dart';
import 'package:marcaii_flutter/strings.dart';

class ViewEmpregos extends StatefulWidget {
  @override
  _ViewEmpregosState createState() => _ViewEmpregosState();
}

class _ViewEmpregosState extends State<ViewEmpregos> with BlocWidget<ViewEmpregos, BlocEmprego>, WillPopForm {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => willPop(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 4,
          title: const Text(Strings.empregos),
          actions: <Widget>[
            AppbarSaveButton(
              onPressed: () => saveForm(resultData: bloc.provideResult()),
            )
          ],
        ),
        body: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              const NomeEmpregoTile(),
              const Divider(indent: 16, endIndent: 16),
              const ViewPorcentagens(),
              const Divider(indent: 16, endIndent: 16),
              const CargaHorariaTile(),
              const Divider(indent: 16, endIndent: 16),
              const FechamentoTile(),
              const _ItemDivider(),
              const HorarioSaidaTile(),
              const _ItemDivider(),
              const EmpregoAtivoTile(),
              const _ItemDivider(),
              const BancoHorasTile(),
              const Divider(indent: 16, endIndent: 16),
              bloc.isCreating ? ViewEmpregoSalarioTile() : const SalariosListTile(),
              const ListDiferenciadas(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get checkForChanges => bloc.didChange();

  @override
  bool get isNewRecord => bloc.isCreating;
}

class _ItemDivider extends StatelessWidget {
  const _ItemDivider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(indent: 64, endIndent: 16);
  }
}
