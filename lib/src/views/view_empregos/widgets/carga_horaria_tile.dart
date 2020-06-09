import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_emprego.dart';
import 'package:marcaii_flutter/src/views/view_empregos/widgets/list_section_decorator.dart';
import 'package:marcaii_flutter/strings.dart';

class CargaHorariaTile extends StatelessWidget {
  const CargaHorariaTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final b = Get.find<BlocEmprego>();
    return StreamObserver<int>(
      stream: b.cargaHoraria,
      onAwaiting: (_) => Container(),
      onSuccess: (_, int carga) {
        return Column(
          children: <Widget>[
            const ListSectionDecorator(label: Strings.cargaHoraria),
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.only(bottom: 16),
              child: CupertinoSegmentedControl<int>(
                groupValue: carga,
                onValueChanged: b.setCargaHoraria,
                children: const <int, Widget>{
                  220: Text("220"),
                  200: Text("200"),
                  180: Text("180"),
                  150: Text("150"),
                  120: Text("120"),
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
