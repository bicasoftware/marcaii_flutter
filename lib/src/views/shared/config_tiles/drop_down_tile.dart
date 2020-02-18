import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/views/shared/config_tiles/base_config_tile.dart';
import 'package:marcaii_flutter/src/views/shared/dropdown_base.dart';

class DropdownTile<T> extends StatelessWidget {
  const DropdownTile({
    @required this.label,
    @required this.icon,
    @required this.initialValue,
    @required this.items,
    @required this.onChanged,
    this.formatter,
    Key key,
  }) : super(key: key);

  final String label;
  final Icon icon;
  final T initialValue;
  final List<T> items;

  ///Função que formata o valor exibido no Dropdownbutton e nas child
  final Function(T item) formatter;

  ///Callback ao selecionar alguma opção
  final void Function(T value) onChanged;

  @override
  Widget build(BuildContext context) {
    return BaseConfigTile(
      trailingWidth: 100,
      icon: icon,
      label: label,
      trailing: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: initialValue,
          items: <DropdownMenuItem<T>>[
            for (final item in items)
              DropdownMenuItem(
                value: item,
                child: Text(
                  formatter != null ? formatter(item) : item.toString(),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}
