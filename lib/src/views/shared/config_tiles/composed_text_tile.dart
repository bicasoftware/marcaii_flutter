import 'package:flutter/material.dart';

class ComposedTextTile extends StatelessWidget {
  const ComposedTextTile({
    @required this.label,
    @required this.hint,
    @required this.initialValue,
    @required this.validator,
    @required this.onSaved,
    @required this.icon,
    Key key,
  }) : super(key: key);

  final Icon icon;
  final String label, hint;
  final String initialValue;
  final Function(String validate) validator, onSaved;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: TextFormField(
        initialValue: initialValue,
        onSaved: onSaved,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
        ),
      ),
    );
  }
}
