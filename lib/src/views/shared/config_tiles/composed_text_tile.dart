import 'package:flutter/material.dart';

class ComposedTextTile extends StatelessWidget {
  const ComposedTextTile({
    @required this.label,
    @required this.hint,
    @required this.initialValue,
    @required this.validator,
    @required this.icon,
    @required this.onChanged,
    Key key,
  }) : super(key: key);

  final Icon icon;
  final String label, hint;
  final String initialValue;
  final Function(String validate) validator, onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: TextFormField(
        initialValue: initialValue,
        onChanged: onChanged,
        validator: validator,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
        ),
      ),
    );
  }
}
