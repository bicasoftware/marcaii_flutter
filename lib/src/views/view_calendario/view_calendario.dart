import 'package:flutter/material.dart';
import 'package:marcaii_flutter/helpers.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/src/views/view_calendario/calendario_header.dart';
import 'package:marcaii_flutter/src/views/view_calendario/calendario_item.dart';

class ViewCalendario extends StatelessWidget {
  const ViewCalendario({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CalendarioHeader(),
        Container(
          padding: const EdgeInsets.all(1),
          child: GridView.count(
            crossAxisCount: 7,
            shrinkWrap: true,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
            children: <Widget>[
              for (int i = 0; i < DateTime(2020, 5, 1).indexWeekday(); i++)
                AspectRatio(
                  aspectRatio: 1.1,
                  child: Container(
                    color: Colors.deepOrangeAccent,
                  ),
                ),
              for (int i = 0; i < 31; i++)
                CalendarioItem(
                  onTap: print,
                  date: DateTime(2020, 5, i + 1),
                  hora: i % 2 == 0
                      ? Horas(
                          id: null,
                          emprego_id: null,
                          inicio: "18:00",
                          termino: "19:00",
                          data: DateTime(2020, 1, i + 1),
                          tipo: 1,
                        )
                      : null,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
