import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/database/dao/dao_empregos.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/database/models/salarios.dart';
import 'package:marcaii_flutter/src/utils/vault.dart';
import 'package:marcaii_flutter/src/utils/vigencia.dart';
import 'package:marcaii_flutter/src/views/view_presentation/pages/logo_welcome.dart';
import 'package:marcaii_flutter/src/views/view_presentation/pages/page_cargahoraria.dart';
import 'package:marcaii_flutter/src/views/view_presentation/pages/page_descricao.dart';
import 'package:marcaii_flutter/src/views/view_presentation/pages/page_porcentagem.dart';
import 'package:marcaii_flutter/src/views/view_presentation/pages/page_salario.dart';
import 'package:marcaii_flutter/src/views/widgets/circle.dart';

class ViewPresentation extends StatefulWidget {
  const ViewPresentation({
    this.onAllSet,
    Key key,
  }) : super(key: key);

  final void Function(List<Empregos>) onAllSet;

  @override
  _ViewPresentationState createState() => _ViewPresentationState();
}

class _ViewPresentationState extends State<ViewPresentation> with SingleTickerProviderStateMixin {
  TabController controller;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  double _salario;
  int _cargaHoraria, _porcNormal, _porcCompleta;
  String _descricao;
  int maxIndex = 5;

  @override
  void initState() {
    super.initState();
    _salario = 1045;
    _cargaHoraria = 220;
    _porcNormal = 50;
    _porcCompleta = 100;
    _descricao = '';
    controller = TabController(
      vsync: this,
      initialIndex: 0,
      length: maxIndex,
    )..addListener(
        () {
          if (!controller.indexIsChanging) {
            setState(() => controller.index);
          }
        },
      );
  }

  void setSalario(double s) {
    setState(() => _salario = s);
  }

  void setCargaHoraria(int c) {
    setState(() => _cargaHoraria = c);
  }

  void onPorcNormalSet(int p) {
    setState(() => _porcNormal = p);
  }

  void onPorcCompletaSet(int p) {
    setState(() => _porcCompleta = p);
  }

  String validate(String s) {
    return s.isEmpty ? "Falta o nome do seu cargo" : null;
  }

  void setDescricao(String s) {
    setState(() => _descricao = s);
  }

  void doOnAllSet() async {
    if (controller.index == maxIndex - 1) {
      if (_salario == 0) {
        controller.animateTo(1);
        _formKey.currentState.validate();
      } else if (_descricao.isEmpty) {
        controller.animateTo(maxIndex - 1);
        _formKey.currentState.validate();
      } else {
        await Vault.setIsDark(false);
        final vigencia = Vigencia.fromString("01/2010");
        final e = Empregos(
          nome: _descricao,
          ativo: true,
          banco_horas: false,
          carga_horaria: _cargaHoraria,
          fechamento: 25,
          saida: "18:00",
          porc: _porcNormal,
          porc_completa: _porcCompleta,
          salarios: [Salarios(valor: _salario, vigencia: vigencia.vigencia, ativo: true)],
          horas: [],
          diferenciadas: [],
          calendario: [],
        );
        final Empregos newEmprego = await DaoEmpregos.insertWithChildren(e);

        widget.onAllSet([newEmprego]);
      }
    }
  }

  void moveNext() {
    if (controller.index >= 0 && controller.index < maxIndex - 1) {
      controller.animateTo(controller.index + 1);
    }
  }

  void movePrev() {
    if (controller.index > 0 && controller.index <= maxIndex) {
      controller.animateTo(controller.index - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: TabBarView(
            controller: controller,
            children: [
              const PageLogo(),
              PageSalario(
                salario: _salario,
                onChanged: setSalario,
              ),
              PageCargaHoraria(
                cargaHoraria: _cargaHoraria,
                onCargaHorariaChanged: setCargaHoraria,
              ),
              PagePorcentagem(
                porcNormal: _porcNormal,
                porcCompleta: _porcCompleta,
                onPorcNormalSet: onPorcNormalSet,
                onPorcCompletaSet: onPorcCompletaSet,
              ),
              PageDescricao(
                descricao: _descricao,
                onChanged: setDescricao,
                validate: validate,
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: theme.cardColor,
          elevation: 2,
          child: Container(
            height: 56,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  child: const Text("Voltar"),
                  onPressed: controller.index == 0 ? null : movePrev,
                ),
                const Spacer(),
                for (var i = 0; i < maxIndex; i++)
                  Container(
                    margin: const EdgeInsets.all(4),
                    child: Circle(
                      color: i == controller.index ? theme.primaryColorLight : Colors.grey,
                      size: 12,
                    ),
                  ),
                const Spacer(),
                controller.index < maxIndex - 1
                    ? FlatButton(
                        child: const Text("Próximo"),
                        onPressed: moveNext,
                      )
                    : FlatButton(
                        child: const Text("Finalizar"),
                        onPressed: doOnAllSet,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
