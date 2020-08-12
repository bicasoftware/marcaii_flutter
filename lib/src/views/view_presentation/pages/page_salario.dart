import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/utils/double_utils.dart';
import 'package:marcaii_flutter/src/views/view_presentation/descricao_item_container.dart';
import 'package:marcaii_flutter/src/views/widgets/light_container.dart';
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
    return PresentationItemContainer(
      asset: 'assets/images/salario.png',
      title: "Qual seu salário?",
      descricao:
          "Coloque só os números, sem a vírgula!\nVale lembrar que o salário mínimo é de R\$ 1045,00",
      widget: LightContainer(
        padding: const EdgeInsets.all(0),
        child: CurrencyTile(
          salario: salario,
          onChanged: (s) => onChanged(currencyStringToDouble(s)),
          label: Strings.salario,
        ),
      ),
    );
  }
}
