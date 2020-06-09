import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:marcaii_flutter/helpers.dart';
import 'package:marcaii_flutter/src/state/totais/totais.dart';
import 'package:marcaii_flutter/src/views/widgets/doubleline_appbar.dart';
import 'package:marcaii_flutter/src/views/view_totais/totais_content.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:rxdart/rxdart.dart';

class ViewTotais extends StatefulWidget {
  const ViewTotais({
    @required this.totais,
    Key key,
  }) : super(key: key);

  final Totais totais;

  @override
  _ViewTotaisState createState() => _ViewTotaisState();
}

class _ViewTotaisState extends State<ViewTotais> {
  final BehaviorSubject<bool> _bhsShowFirst = BehaviorSubject<bool>.seeded(true);

  @override
  void dispose() {
    _bhsShowFirst.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DoubleLineAppbar(
        title: "Totais de ${Consts.meses[widget.totais.mes - 1]}",
        subtitle: "Entre ${widget.totais.inicio.asString()} e ${widget.totais.termino.asString()}",
        elevation: 1,
        actions: <Widget>[
          StreamObserver<bool>(
            stream: _bhsShowFirst.stream,
            onSuccess: (_, b) => IconButton(
              icon: b ? Icon(LineAwesomeIcons.list) : Icon(LineAwesomeIcons.th_list),
              onPressed: () => _bhsShowFirst.sink.add(!b),
            ),
          )
        ],
      ),
      body: StreamObserver<bool>(
        stream: _bhsShowFirst,
        onSuccess: (_, showFirst) => AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          crossFadeState: showFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          firstChild: SingleChildScrollView(
            ///View com todas as horas do período;
            child: TotaisContent(
              detalhe: widget.totais.totaisGeral,
              tipo: 3,
            ),
          ),
          secondChild: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                ///View horas do período separadas por tipo e ordenados por data
                TotaisContent(
                  detalhe: widget.totais.normais,
                  tipo: 0,
                ),
                TotaisContent(
                  detalhe: widget.totais.feriados,
                  tipo: 1,
                ),
                if (widget.totais.difer != null)
                  for (final d in widget.totais.difer)
                    TotaisContent(
                      tipo: 2,
                      detalhe: d,
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
