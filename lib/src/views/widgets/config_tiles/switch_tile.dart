import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/views/widgets/config_tiles/base_config_tile.dart';

class SwitchTile extends StatelessWidget {
  const SwitchTile({
    @required this.initialValue,
    @required this.label,
    @required this.icon,
    @required this.onChanged,
    Key key,
  }) : super(key: key);

  final bool initialValue;
  final String label;
  final Icon icon;
  final Function(bool b) onChanged;

  @override
  Widget build(BuildContext context) {
    return BaseConfigTile(
      onTap: () => onChanged(!initialValue),
      label: label,
      icon: icon,
      trailing: Switch.adaptive(
        value: initialValue,
        onChanged: onChanged,
      ),
      trailingWidth: 60,
    );
  }
}
