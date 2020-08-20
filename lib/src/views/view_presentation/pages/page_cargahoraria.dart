import 'package:flutter/material.dart';
import 'package:flutter_utils/config_tiles/multi_option_controll.dart';
import 'package:marcaii_flutter/src/views/view_presentation/descricao_item_container.dart';
import 'package:marcaii_flutter/src/views/widgets/light_container.dart';
import 'package:marcaii_flutter/strings.dart';

class PageCargaHoraria extends StatelessWidget {
  const PageCargaHoraria({
    @required this.cargaHoraria,
    @required this.onCargaHorariaChanged,
    Key key,
  }) : super(key: key);

  final int cargaHoraria;
  final Function(int carga) onCargaHorariaChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PresentationItemContainer(
      asset: 'assets/images/cargahoraria.png',
      title: "E sua carga horária?",
      descricao:
          "A carga horária padrão é de 220 horas por mês, ou 8 horas diárias. Se tiver dúvidas, converse com seu contrante :)",
      widget: LightContainer(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: MultiOptionControll(
          label: Strings.cargaHoraria,
          initValue: cargaHoraria,
          selectedColor: theme.accentColor,
          onValueChanged: onCargaHorariaChanged,
          borderColor: theme.accentColor,
          children: Maps.cargaHoraria,
        ),
      ),
    );
  }
}
