import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:marcaii_flutter/helpers.dart';
import 'package:marcaii_flutter/src/state/totais/totais.dart';
import 'package:marcaii_flutter/src/utils/doubleline_appbar.dart';
import 'package:marcaii_flutter/src/views/view_totais/totais_content.dart';
import 'package:marcaii_flutter/strings.dart';

class ViewTotais extends StatefulWidget {
  const ViewTotais({
    @required this.totais,
    Key key,
  }) : super(key: key);

  final Totais totais;

  @override
  _ViewTotaisState createState() => _ViewTotaisState(totais);
}

class _ViewTotaisState extends State<ViewTotais> with SingleTickerProviderStateMixin {
  _ViewTotaisState(this.totais);

  final Totais totais;
  bool showFirst;

  final scaffKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    showFirst = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffKey,
      appBar: DoubleLineAppbar(
        title: "Totais de ${Consts.meses[totais.mes - 1]}",
        subtitle: "Entre ${totais.inicio.asString()} e ${totais.termino.asString()}",
        elevation: 1,
        actions: <Widget>[
          IconButton(
            icon: Icon(LineAwesomeIcons.file_pdf_o),
            onPressed: () {
              Scaffold.of(scaffKey.currentContext).showSnackBar(
                const SnackBar(content: Text("falta implementar")),
              );
            },
          ),
          IconButton(
            icon: showFirst ? Icon(LineAwesomeIcons.list) : Icon(LineAwesomeIcons.th_list),
            onPressed: () => setState(() => showFirst = !showFirst),
          )
        ],
      ),
      body: AnimatedCrossFade(
        duration: const Duration(milliseconds: 300),
        crossFadeState: showFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        firstChild: SingleChildScrollView(
          ///View com todas as horas do período;
          child: TotaisContent(
            detalhe: totais.totaisGeral,
            tipo: 3,
          ),
        ),
        secondChild: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              ///View horas do período separadas por tipo e ordenados por data
              TotaisContent(
                detalhe: totais.normais,
                tipo: 0,
              ),
              TotaisContent(
                detalhe: totais.feriados,
                tipo: 1,
              ),
              if (totais.difer != null)
                for (final d in totais.difer)
                  TotaisContent(
                    tipo: 2,
                    detalhe: d,
                  )
            ],
          ),
        ),
      ),
    );
  }
}
