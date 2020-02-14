import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/src/views/shared/circle.dart';
import 'package:marcaii_flutter/helpers.dart';

class CalendarioItem extends StatelessWidget {
  const CalendarioItem({
    this.date,
    this.onTap,
    this.hora,
    Key key,
  }) : super(key: key);

  final DateTime date;
  final Horas hora;
  final void Function(Horas hora) onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: Colors.deepOrangeAccent,
      padding: const EdgeInsets.all(8),
      child: AspectRatio(
        aspectRatio: 1.1,
        child: date != null
            ? InkWell(
                onTap: () => onTap(hora),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      date.paddedWeekday(2),
                      style: theme.textTheme.subhead.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (hora != null)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Spacer(),
                          Circle(
                            color: hora.getColor(),
                            size: 8,
                          ),
                          const Spacer(),
                        ],
                      )
                  ],
                ),
              )
            : Container(),
      ),
    );
  }
}
