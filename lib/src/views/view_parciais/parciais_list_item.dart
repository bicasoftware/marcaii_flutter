import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/src/views/shared/squared_card.dart';
import 'package:marcaii_flutter/helpers.dart';

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
    return SquaredCard(
      child: ListTile(
        onTap: () => onPressed(hora),
        leading: CircleAvatar(
          backgroundColor: hora.getColor(),
          child: Icon(
            Icons.access_time,
          ),
        ),
        title: Text(hora.data.asString()),
        subtitle: Text("${hora.inicio} | ${hora.termino} | 60 minutos"),
        trailing: IconButton(
          icon: Icon(
            Icons.delete_sweep,
            color: Colors.red,
          ),
          onPressed: () => onDelete(hora),
        ),
      ),
    );
  }
}
