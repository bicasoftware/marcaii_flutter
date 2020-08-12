import 'package:flutter/material.dart';
import 'package:flutter_utils/config_tiles/composed_text_tile.dart';

import 'package:marcaii_flutter/src/views/view_presentation/descricao_item_container.dart';
import 'package:marcaii_flutter/src/views/widgets/light_container.dart';

class PageDescricao extends StatelessWidget {
  const PageDescricao({
    @required this.descricao,
    @required this.onChanged,
    @required this.validate,
    Key key,
  }) : super(key: key);

  final String descricao;
  final Function(String s) onChanged;
  final String Function(String s) validate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PresentationItemContainer(
        title: "E qual sua profissão?",
        descricao: "Use um nome fácil pra descrever seu cargo, tipo Auxiliar de Escritório ou Contador",
        asset: 'assets/images/descricao.png',
        widget: LightContainer(
          padding: const EdgeInsets.all(8),
          child: ComposedTextTile(
            icon: Icon(Icons.work, color: theme.accentColor),
            maxLength: null,
            inputType: TextInputType.name,
            onChanged: onChanged,
            initialValue: descricao,
            hint: "Contador",
            label: "Descrição Cargo",
            validator: validate,
          ),
        ),
      ),
    );
  }
}
