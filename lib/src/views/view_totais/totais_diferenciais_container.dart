import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/state/totais_domain/totais_detalhes.dart';
import 'package:marcaii_flutter/src/views/view_totais/totais_colored_indicator.dart';
import 'package:marcaii_flutter/src/views/view_totais/totais_content.dart';

class TotaisDiferenciaisContainer extends StatelessWidget {
  const TotaisDiferenciaisContainer({
    @required this.diferenciadas,
    Key key,
  }) : super(key: key);

  final List<TotaisDetalhe> diferenciadas;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          for (final d in diferenciadas)
            TotaisContent(
              tipo: 2,
              detalhe: d,
            )
        ],
      ),
    );
  }
}
