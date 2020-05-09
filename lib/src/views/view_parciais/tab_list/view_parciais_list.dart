import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/src/views/view_parciais/tab_list/parciais_list_item.dart';

class ViewParciaisList extends StatelessWidget {
  const ViewParciaisList({
    @required this.horas,
    Key key,
  }) : super(key: key);

  final List<Horas> horas;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: ListView(
        children: <Widget>[
          for (int i = 0; i < horas.length; i++)
            ParciaisListItem(
              hora: horas[i],
              porc: 30,
              valorReceber: 6.30,
            ),
        ],
      ),
    );
  }
}
