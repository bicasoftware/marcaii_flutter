import 'package:flutter/material.dart';
import 'package:marcaii_flutter/helpers.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';

class ParciaisListItem extends StatelessWidget {
  const ParciaisListItem({
    @required this.hora,
    @required this.onDelete,
    @required this.onPressed,
    Key key,
  }) : super(key: key);

  final Horas hora;
  final void Function(Horas hora) onDelete;
  final void Function(Horas hora) onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onPressed(hora),
      leading: Icon(Icons.date_range),
      title: Text(hora.data.asString()),
      subtitle: Text("${hora.inicio} | ${hora.termino} | 60 minutos"),
      trailing: Text(
        hora.getTipo(),
        style: Theme.of(context).textTheme.caption.copyWith(color: hora.getColor()),
      ),
    );
  }
}
