import 'package:flutter/material.dart';
import 'package:marcaii_flutter/context_helper.dart';
import 'package:marcaii_flutter/src/utils/helpers/date_helper.dart';
import 'package:marcaii_flutter/src/views/view_calendario/models/calendario_child.dart';
import 'package:marcaii_flutter/src/utils/helpers/hora_helper.dart';

class CalendarioItem extends StatelessWidget {
  const CalendarioItem({
    @required this.onTap,
    @required this.isToday,
    @required this.childContent,
    Key key,
  }) : super(key: key);

  final void Function(CalendarioChild) onTap;
  final bool isToday;
  final CalendarioChild childContent;

  Color getHighlightColor(BuildContext context) {
    return isToday ? context.theme.highlightColor : null;
  }

  @override
  Widget build(BuildContext context) {
    if (childContent.date != null) {
      return Ink(
        color: getHighlightColor(context),
        child: InkWell(
          onTap: () {
            onTap(childContent);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                childContent.date.paddedWeekday(2),
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(height: 4),
              if (childContent.hora != null)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Spacer(),
                    Center(
                      child: Container(
                        height: 4,
                        width: 20,
                        decoration: BoxDecoration(
                          color: childContent.hora.getColor(),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                )
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
