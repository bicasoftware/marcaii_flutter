import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/views/shared/config_tiles/base_config_tile.dart';
import 'package:marcaii_flutter/helpers.dart';

class TimePickerTile extends StatelessWidget {
  const TimePickerTile({
    Key key,
    this.label,
    this.initialTime,
    this.icon,
    this.onTimeSet,
  }) : super(key: key);

  final String label;
  final TimeOfDay initialTime;
  final Icon icon;
  final Function(TimeOfDay) onTimeSet;

  @override
  Widget build(BuildContext context) {
    return BaseConfigTile(
      trailingWidth: 50,
      label: label,
      icon: icon,
      trailing: Text(
        initialTime.toShortString(),
        style: Theme.of(context).textTheme.subhead,
        textAlign: TextAlign.end,
      ),
      onTap: () async {
        final newTime = await showTimePicker(
          context: context,
          initialTime: initialTime,
        );

        if (newTime != null && newTime != initialTime) {
          onTimeSet(newTime);
        }
      },
    );
  }
}
