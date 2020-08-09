import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/views/view_presentation/descricao_item_container.dart';

class PageDiferenciadas extends StatelessWidget {
  const PageDiferenciadas({
    this.diferenciadas,
    this.onAdd,
    Key key,
  }) : super(key: key);

  final List<Map<int, int>> diferenciadas;
  final void Function(int d) onAdd;

  @override
  Widget build(BuildContext context) {
    return PresentationItemContainer(
      title: "Faz alguma hora diferenciada?",
      descricao:
          "Em algumas profissões é comum haver horarios com valor diferenciado em determinados dias da semana. Caso você não faça, é só pular para o próximo.",
      asset: 'assets/images/diferenciadas.png',
      widget: Container(),
    );
  }
}
