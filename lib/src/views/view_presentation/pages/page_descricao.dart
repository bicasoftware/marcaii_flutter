import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/views/view_presentation/descricao_item_container.dart';

class PageDescricao extends StatelessWidget {
  const PageDescricao({
    this.descricao,
    this.onChanged,
    Key key,
  }) : super(key: key);
  final String descricao;

  final Function(String s) onChanged;

  @override
  Widget build(BuildContext context) {
    return PresentationItemContainer(
      title: "E o qual sua profissão?",
      descricao:
          "Use um nome fácil pra descrever seu cargo, tipo Auxiliar de Escritório ou Contador",
      asset: 'assets/images/descricao.png',
      widget: Container(
        padding: const EdgeInsets.all(16),
        child: TextFormField(
          onChanged: onChanged,
          initialValue: descricao,
          decoration: const InputDecoration(
            labelText: "Descrição Cargo",
            hintText: "Contador",
          ),
        ),

      ),
    );
  }
}
