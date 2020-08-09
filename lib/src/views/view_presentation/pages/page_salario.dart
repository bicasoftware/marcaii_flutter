import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/views/view_presentation/descricao_item_container.dart';
import 'package:marcaii_flutter/src/views/widgets/dialogs.dart';
import 'package:marcaii_flutter/src/views/widgets/salario_tile.dart';
import 'package:marcaii_flutter/strings.dart';

class PageSalario extends StatelessWidget {
  const PageSalario({
    @required this.salario,
    @required this.onChanged,
    Key key,
  }) : super(key: key);

  final double salario;
  final Function(double s) onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final double s = await showSalarioPicker(context: context, salario: salario);
        if (s != null) {
          onChanged(s);
        }
      },

      //TODO - Adicionar botão de editar no canto do card e chamar dialog de salario
      child: PresentationItemContainer(
        asset: 'assets/images/salario.png',
        title: "Qual seu salário?",
        descricao:
            "Para que o cálculo das suas horas extras possa ser calculado com perfeição, eu preciso saber seu salário e quantas horas você trabalha por mês",
        widget: CurrencyTile(
          salario: salario,
          onChanged: null,
          label: Strings.salario,
        ),
      ),
    );
  }
}
