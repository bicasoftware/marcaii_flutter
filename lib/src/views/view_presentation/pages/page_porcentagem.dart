import 'package:flutter/material.dart';
import 'package:flutter_utils/flutter_utils.dart';
import 'package:marcaii_flutter/src/views/view_empregos/widgets/porcentagens/porcentagem_container.dart';
import 'package:marcaii_flutter/src/views/view_presentation/descricao_item_container.dart';
import 'package:marcaii_flutter/src/views/widgets/light_container.dart';
import 'package:marcaii_flutter/strings.dart';

class PagePorcentagem extends StatelessWidget {
  const PagePorcentagem({
    @required this.porcNormal,
    @required this.porcCompleta,
    @required this.onPorcNormalSet,
    @required this.onPorcCompletaSet,
    Key key,
  }) : super(key: key);

  final int porcNormal, porcCompleta;

  final Function(int p) onPorcNormalSet, onPorcCompletaSet;

  Future<void> popDialog(BuildContext context, int value, String label, Function(int) onTap) async {
    final String r = await Dialogs.showIntegerDialog(
      context: context,
      label: "Valor",
      title: "Valor em Porcento",
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
    return PresentationItemContainer(
      asset: 'assets/images/porcentagens.png',
      title: "Sabe suas porcentagens?",
      descricao:
          "As porcentagens em dias da semana, por padrão são 50% e em domingos e feriados são 100%. Caso no seu contrato seja diferente, é só atualizar.",
      widget: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: LightContainer(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              PorcentagemContainer(
                label: Strings.porcentagemNormal,
                porc: porcNormal,
                iconColor: Consts.horaColor[0],
                onTap: () async {
                  await popDialog(
                    context,
                    porcNormal,
                    Strings.porcentagemNormal,
                    onPorcNormalSet,
                  );
                },
              ),
              const SizedBox(
                height: 56,
                child: VerticalDivider(),
              ),
              PorcentagemContainer(
                label: Strings.porcentagemCompleta,
                porc: porcCompleta,
                iconColor: Consts.horaColor[1],
                onTap: () async {
                  await popDialog(
                    context,
                    porcCompleta,
                    Strings.porcentagemCompleta,
                    onPorcCompletaSet,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
