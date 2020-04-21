import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/src/views/view_parciais/parciais_list_item.dart';
import 'package:marcaii_flutter/strings.dart';

class ViewParciais extends StatefulWidget {
  const ViewParciais({Key key}) : super(key: key);

  @override
  _ViewParciaisState createState() => _ViewParciaisState();
}

class _ViewParciaisState extends State<ViewParciais> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.parciais),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.attach_file),
            onPressed: () {},
          )
        ],
      ),
      body: ListView(
        shrinkWrap: true,
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
