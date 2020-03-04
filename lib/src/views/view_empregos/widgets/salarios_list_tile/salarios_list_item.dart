import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/database/models/salarios.dart';
import 'package:marcaii_flutter/src/utils/double_utils.dart';

class SalariosListItem extends StatelessWidget {
  const SalariosListItem({
    @required this.salario,
    @required this.onDelete,
    @required this.onPressed,
    Key key,
  }) : super(key: key);

  final Salarios salario;
  final void Function(Salarios s) onDelete, onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => onPressed(salario),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 0, top: 0, bottom: 0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.calendar_today,
                    color: Colors.deepPurple,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    salario.vigencia,
                    textAlign: TextAlign.start,
                    style: theme.textTheme.subhead,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                doubleToCurrency(salario.valor),
                textAlign: TextAlign.start,
                style: theme.textTheme.subhead.copyWith(
                  color: theme.accentColor,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.red),
                onPressed: () => onDelete(salario),
              ),
            )
          ],
        ),
      ),
    );
  }
}
