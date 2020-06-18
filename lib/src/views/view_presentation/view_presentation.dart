import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:marcaii_flutter/src/database/dao/dao_diferencidas.dart';
import 'package:marcaii_flutter/src/database/dao/dao_empregos.dart';
import 'package:marcaii_flutter/src/database/dao/dao_horas.dart';
import 'package:marcaii_flutter/src/database/dao/dao_salarios.dart';
import 'package:marcaii_flutter/src/database/models/diferenciadas.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/src/database/models/salarios.dart';
import 'package:marcaii_flutter/src/utils/vault.dart';
import 'package:marcaii_flutter/src/utils/vigencia.dart';
import 'package:marcaii_flutter/src/views/widgets/circle.dart';
import 'package:rxdart/rxdart.dart';

class ViewPresentation extends StatefulWidget {
  //TODO - Gerar View com apresentação do app;
  //Pedindo Salario, nome do emprego, carga horária, hora de saída, valor das porcentagens e valores diferenciais

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
  final int maxIndex = 7;
  final BehaviorSubject<int> _bhsPosition = BehaviorSubject<int>();
  Stream<int> get outPosition => _bhsPosition.stream;
  Sink<int> get _inPosition => _bhsPosition.sink;

  List<Color> colorList = [
    Colors.red,
    Colors.orange,
    Colors.amber,
    Colors.teal,
    Colors.lightBlue,
    Colors.black,
    Colors.green
  ];

  void doOnAllSet() async {
    await Vault.setIsDark(false);
    final vigencia = Vigencia.fromString("01/2010");
    final e = await DaoEmpregos.insert(
      Empregos(
        nome: "Analista",
        ativo: true,
        banco_horas: false,
        carga_horaria: 220,
        fechamento: 25,
        saida: "18:00",
        porc: 50,
        porc_completa: 100,
        salarios: [],
        horas: [],
        diferenciadas: [],
        calendario: [],
      ),
    );

    final s = await DaoSalarios.insert(
      Salarios(emprego_id: e.id, ativo: true, valor: 1320.0, vigencia: vigencia.vigencia),
    );

    final d = await DaoDiferenciadas.insert(Diferenciadas(
      emprego_id: e.id,
      ativo: true,
      vigencia: vigencia.vigencia,
      porc: 110,
      weekday: 0,
    ));

    final h1 = await DaoHoras.insert(Horas(
      emprego_id: e.id,
      data: DateTime(2020, 6, 8),
      tipo: 0,
      inicio: "18:00",
      termino: "19:00",
    ));

    final h2 = await DaoHoras.insert(Horas(
      emprego_id: e.id,
      data: DateTime(2020, 6, 9),
      tipo: 1,
      inicio: "18:00",
      termino: "19:00",
    ));

    final h3 = await DaoHoras.insert(Horas(
      emprego_id: e.id,
      data: DateTime(2020, 6, 7),
      tipo: 2,
      inicio: "10:00",
      termino: "12:00",
    ));

    e
      ..salarios.add(s)
      ..diferenciadas.add(d)
      ..horas.addAll([h1, h2, h3]);

    widget.onAllSet([e]);
  }

  void moveNext() {
    if (controller.index >= 0 && controller.index < maxIndex - 1) {
      _inPosition.add(_bhsPosition.value += 1);
      controller.animateTo(_bhsPosition.value);
      print(_bhsPosition.value);
    }
  }

  void movePrev() {
    if (controller.index > 0 && controller.index <= maxIndex) {
      _inPosition.add(_bhsPosition.value -= 1);
      controller.animateTo(_bhsPosition.value);
    }
  }

  @override
  void initState() {
    super.initState();
    controller = TabController(
      vsync: this,
      initialIndex: 0,
      length: maxIndex,
    )..addListener(() {
        if (!controller.indexIsChanging) {
          _inPosition.add(controller.index);
        }
      });
    _inPosition.add(0);
  }

  @override
  void dispose() {
    _bhsPosition.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: TabBarView(
          controller: controller,
          children: <Widget>[for (var i = 0; i < maxIndex; i++) Container(color: colorList[i])],
        ),
/*       body: Center(
          child: MaterialButton(
            color: Get.theme.primaryColor,
            onPressed: doOnAllSet,
          ),
        ), */
        bottomNavigationBar: BottomAppBar(
          color: Get.theme.cardColor,
          elevation: 4,
          child: Container(
            padding: const EdgeInsets.all(8),
            child: StreamObserver<int>(
              stream: outPosition,
              onSuccess: (_, pos) => Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    child: const Text("Voltar"),
                    onPressed: pos == 0 ? null : movePrev,
                  ),
                  const Spacer(),
                  for (var i = 0; i < maxIndex; i++)
                    Container(
                      margin: const EdgeInsets.all(4),
                      child: Circle(
                        color: i == pos ? Get.theme.primaryColorLight : Colors.grey,
                        size: 12,
                      ),
                    ),
                  const Spacer(),
                  pos < maxIndex - 1
                      ? FlatButton(
                          child: const Text("Próximo"),
                          onPressed: moveNext,
                        )
                      : FlatButton(
                          child: const Text("Finalizar"),
                          // onPressed: pos < maxIndex -1 ? moveNext : null,
                          onPressed: doOnAllSet,
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
