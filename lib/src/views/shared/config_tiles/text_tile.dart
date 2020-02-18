import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/views/shared/config_tiles/base_config_tile.dart';

class TextTile extends StatelessWidget {
  const TextTile({
    @required this.label,
    @required this.icon,
    @required this.hint,
    this.controller,
    this.initialValue,
    this.validator,
    this.onSaved,
    Key key,
  })  : assert(controller != null || initialValue != null),
        super(key: key);

  final String label;
  final Icon icon;
  final String hint;
  final String initialValue;
  final TextEditingController controller;
  final void Function(String value) validator, onSaved;

  @override
  Widget build(BuildContext context) {
    return BaseConfigTile(
      label: label,
      icon: icon,
      trailing: TextFormField(
        initialValue: initialValue,
        controller: controller,
        validator: validator,
        onSaved: onSaved,
        decoration: InputDecoration.collapsed(
          hintText: hint,
        ),
      ),
    );
  }
}
