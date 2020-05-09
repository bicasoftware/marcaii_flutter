import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:marcaii_flutter/helpers.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/src/state/totais_domain/totais.dart';
import 'package:marcaii_flutter/src/state/totais_domain/totais_item.dart';
import 'package:marcaii_flutter/src/utils/doubleline_appbar.dart';
import 'package:marcaii_flutter/src/views/view_parciais/totais_colored_indicator.dart';
import 'package:marcaii_flutter/src/views/view_parciais/totais_content.dart';
import 'package:marcaii_flutter/src/views/view_parciais/view_parciais_bottombar.dart';
import 'package:marcaii_flutter/strings.dart';

class ViewParciais extends StatefulWidget {
  const ViewParciais({Key key}) : super(key: key);

  @override
  _ViewParciaisState createState() => _ViewParciaisState();
}

class _ViewParciaisState extends State<ViewParciais> with SingleTickerProviderStateMixin {
  final scaffKey = GlobalKey<ScaffoldState>();
  bool isVisible;
  static const tabLenght = 4;

  TabController controller;

  int pos;

  void setPos(int pos) {
    setState(() => this.pos = pos);
    controller.animateTo(pos);
  }

  @override
  void initState() {
    isVisible = false;
    pos = 0;
    controller = TabController(vsync: this, initialIndex: 0, length: tabLenght);
    super.initState();
  }

  ///TODO - Preparar layout para diferenciadas, mostrando dia da semana e porcentagem

  final totais = Totais(
      mes: 5,
      inicio: DateTime(2020, 4, 26),
      termino: DateTime(2020, 5, 25),
      items: const <TotaisItem>[
        TotaisItem(
          tipo: 0,
          total: 36.0,
          minutos: 60,
          porcentagem: 50,
          weekday: null,
        ),
        TotaisItem(
          tipo: 1,
          total: 36.0,
          minutos: 60,
          porcentagem: 100,
          weekday: null,
        ),
        TotaisItem(
          tipo: 2,
          total: 60.0,
          minutos: 60,
          porcentagem: 140,
          weekday: 0,
        ),
        TotaisItem(
          tipo: 2,
          total: 90.0,
          minutos: 60,
          porcentagem: 180,
          weekday: 6,
        ),
      ]);

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

  Color get color => Consts.horaColor[pos];

  String get horaTipo => Consts.tipoHoraPlural[pos];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      key: scaffKey,
      appBar: DoubleLineAppbar(
        title: "Totais de ${Consts.meses[totais.mes]}",
        subtitle: "Entre ${totais.inicio.asString()} e ${totais.termino.asString()}",
        backgroundColor: color,
        elevation: 0,
      ),
      body: TotaisColoredIndicator(
        color: color,
        child: TotaisContent(
          key: UniqueKey(),
          color: color,
          label: horaTipo,
          totais: totais,
          pos: pos,
          horas: horas,
        ),
      ),
      bottomNavigationBar: ViewParciaisBottombar(
        onTap: setPos,
        pos: pos,
      ),
    );
  }
}
