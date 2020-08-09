import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marcaii_flutter/helpers.dart';
import 'package:marcaii_flutter/src/state/calendario/calendario_child.dart';

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

  Color getHighlightColor() {
    return isToday ? Get.theme.highlightColor : null;
  }

  @override
  Widget build(BuildContext context) {
    if (childContent.date != null) {
      return Ink(
        color: getHighlightColor(),
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
                    // Circle(
                    //   color: childContent.hora.getColor(),
                    //   size: 8,
                    // ),
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
