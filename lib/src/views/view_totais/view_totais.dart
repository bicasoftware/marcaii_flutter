import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:marcaii_flutter/helpers.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/src/state/totais_domain/totais.dart';
import 'package:marcaii_flutter/src/state/totais_domain/totais_detalhes.dart';
import 'package:marcaii_flutter/src/utils/doubleline_appbar.dart';
import 'package:marcaii_flutter/src/views/view_totais/totais_content.dart';
import 'package:marcaii_flutter/src/views/view_totais/totais_diferenciais_container.dart';
import 'package:marcaii_flutter/src/views/view_totais/view_totais_bottombar.dart';
import 'package:marcaii_flutter/strings.dart';

class ViewParciais extends StatefulWidget {
  const ViewParciais({Key key}) : super(key: key);

  static final totais = Totais(
    mes: 5,
    inicio: DateTime(2020, 4, 26),
    termino: DateTime(2020, 5, 25),
    minutos: 360,
    totalReceber: 128.56,
    normais: TotaisDetalhe(
      total: 36.0,
      minutos: 60,
      porcentagem: 50,
      weekday: null,
      horas: [...horas],
    ),
    feriados: TotaisDetalhe(
      total: 36.0,
      minutos: 60,
      porcentagem: 50,
      weekday: null,
      horas: [...horas],
    ),
   difer: const [],
    /* difer: <TotaisDetalhe>[
      TotaisDetalhe(
        total: 36.0,
        minutos: 60,
        porcentagem: 50,
        weekday: 0,
        horas: [...horas],
      ),
      TotaisDetalhe(
        total: 48.0,
        minutos: 120,
        porcentagem: 140,
        weekday: 1,
        horas: [...horas],
      ),
      TotaisDetalhe(
        total: 120.0,
        minutos: 60,
        porcentagem: 120,
        weekday: 5,
        horas: [...horas],
      ),
    ], */
  );

  static final horas = <Horas>[
    Horas(
      id: 1,
      emprego_id: 1,
      data: DateTime(2020, 6, 12),
      inicio: "17:00",
      termino: "18:00",
      tipo: 0,
    ),
    Horas(
      id: 1,
      emprego_id: 1,
      data: DateTime.now(),
      inicio: "17:00",
      termino: "18:00",
      tipo: 2,
    ),
    Horas(
      id: 2,
      emprego_id: 1,
      data: DateTime.now(),
      inicio: "17:00",
      termino: "18:00",
      tipo: 1,
    ),
  ];

  @override
  _ViewParciaisState createState() => _ViewParciaisState(totais);
}

class _ViewParciaisState extends State<ViewParciais> with SingleTickerProviderStateMixin {
  _ViewParciaisState(this.totais);

  final Totais totais;
  int _tabLenght;

  final scaffKey = GlobalKey<ScaffoldState>();
  TabController controller;
  int pos;

  List<Color> _colors() {
    return <Color>[
      Colors.teal,
      Colors.amber,
      if (_tabLenght > 3) Colors.red,
      Colors.purple,
    ];
  }

  List<String> _labels() {
    return <String>[
      Strings.normais,
      Strings.feriados,
      if (_tabLenght > 3) Strings.diferenciadas,
      Strings.totais,
    ];
  }

  void setPos(int pos) {
    setState(() => this.pos = pos);
    controller.animateTo(pos);
  }

  @override
  void initState() {
    pos = 0;
    _tabLenght = 3 + (totais.difer.isEmpty ? 0 : 1);
    controller = TabController(vsync: this, initialIndex: 0, length: _tabLenght);
    print(_tabLenght);
    super.initState();
  }

  Color get color {
    return _colors()[pos];
  }

  String get horaTipo => _labels()[pos];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffKey,
      appBar: DoubleLineAppbar(
        title: "Totais de ${Consts.meses[totais.mes]}",
        subtitle: "Entre ${totais.inicio.asString()} e ${totais.termino.asString()}",
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            TotaisContent(
              detalhe: totais.normais,
              tipo: 0,
            ),
            //Totais Horas em Feriados
            TotaisContent(
              detalhe: totais.feriados,
              tipo: 1,
            ),
            if (totais.difer.isNotEmpty)
              TotaisDiferenciaisContainer(diferenciadas: totais.difer),
          ],
        ),
      ),
      /* body: TabBarView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          //Totais horas normais
          TotaisContent(
            detalhe: totais.normais,
            tipo: 0,
          ),
          //Totais Horas em Feriados
          TotaisContent(
            detalhe: totais.feriados,
            tipo: 1,
          ),
          //Totais diferenciados
          if (totais.difer.isNotEmpty)
            TotaisDiferenciaisContainer(diferenciadas: totais.difer),
          //Totais gerais
          Container(
            color: Colors.lightBlue,
            child: const Center(child: Text("Calcular totais!")),
          ),
        ],
      ),
      bottomNavigationBar: ViewTotaisBottombar(
        onTap: setPos,
        pos: pos,
        hasDifer: totais.difer.isNotEmpty,
      ), */
    );
  }
}
