import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_main.dart';
import 'package:marcaii_flutter/src/utils/vigencia.dart';
import 'package:provider/provider.dart';

class CalendarioNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocMain>(context);
    return Container(
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          StreamObserver<Vigencia>(
            stream: b.outVigencia,
            onSuccess: (_, vig) => FlatButton.icon(
              icon: Icon(Icons.date_range),
              label: Text(vig.vigenciaExtenso),
              onPressed: () {},
            ),
          ),
          const Spacer(),
          IconButton(
            icon: Icon(Icons.keyboard_arrow_left),
            onPressed: b.decMes,
          ),
          IconButton(
            icon: Icon(Icons.keyboard_arrow_right),
            onPressed: b.incMes,
          ),
        ],
      ),
    );
  }
}
