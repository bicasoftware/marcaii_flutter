import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:marcaii_flutter/src/database/models/salarios.dart';
import 'package:marcaii_flutter/src/utils/double_utils.dart';
import 'package:marcaii_flutter/src/utils/vigencia.dart';

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
    return ListTile(
      leading: const Icon(
        LineAwesomeIcons.money,
        color: Colors.lightGreen,
      ),
      title: Text(Vigencia.fromString(salario.vigencia).vigenciaExtenso),
      subtitle: Text(doubleToCurrency(salario.valor)),
      trailing: IconButton(
        icon: const Icon(Icons.close, color: Colors.red),
        onPressed: () => onDelete(salario),
      ),
      onTap: () => onPressed(salario),
    );
  }
}
