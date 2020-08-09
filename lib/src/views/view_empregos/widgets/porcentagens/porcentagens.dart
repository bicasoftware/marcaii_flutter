import 'package:flutter/material.dart';
import 'package:flutter_utils/async_widgets/async_widget.dart';
import 'package:flutter_utils/flutter_utils.dart';
import 'package:get/get.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_emprego.dart';
import 'package:marcaii_flutter/src/views/view_empregos/widgets/list_section_decorator.dart';
import 'package:marcaii_flutter/src/views/view_empregos/widgets/porcentagens/porcentagem_container.dart';
import 'package:marcaii_flutter/strings.dart';

class ViewPorcentagens extends StatelessWidget {
  const ViewPorcentagens({Key key}) : super(key: key);

  Future<void> popDialog(BuildContext context, int value, String label, Function(int) onTap) async {
    final String r = await Dialogs.showIntegerDialog(
      context: context,
      label: "Valor",
      title: "Nova Porcentagem",
      confirmButton: Strings.salvar,
      initValue: value.toString(),
      maxLength: 3,
    );

    if (r != null) {
      onTap(int.parse(r));
    }
  }

  @override
  Widget build(BuildContext context) {
    final b = Get.find<BlocEmprego>();

    return MergedStreamObserver(
      streams: [b.porcNormal, b.porcCompleta],
      onSuccess: (BuildContext context, List<dynamic> data) {
        final int porcNormal = data[0];
        final int porcCompleta = data[1];

        return Column(
          children: <Widget>[
            const ListSectionDecorator(label: Strings.porcentagem),
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  PorcentagemContainer(
                    label: Strings.porc,
                    porc: porcNormal,
                    iconColor: Consts.horaColor[0],
                    onTap: () async {
                      await popDialog(
                        context,
                        porcNormal,
                        Strings.porc,
                        b.setPorcNormal,
                      );
                    },
                  ),
                  PorcentagemContainer(
                    label: Strings.porcCompleta,
                    porc: porcCompleta,
                    iconColor: Consts.horaColor[1],
                    onTap: () async {
                      await popDialog(
                        context,
                        porcCompleta,
                        Strings.porcCompleta,
                        b.setPorcCompleta,
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
