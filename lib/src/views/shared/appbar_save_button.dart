import 'package:flutter/material.dart';
import 'package:marcaii_flutter/strings.dart';

class AppbarSaveButton extends StatelessWidget {

  const AppbarSaveButton({
    @required this.onPressed,
    Key key,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(Strings.salvar, style: Theme.of(context).textTheme.subhead),
      onPressed: onPressed,
    );
  }
}
