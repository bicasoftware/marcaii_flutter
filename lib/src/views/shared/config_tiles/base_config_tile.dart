import 'package:flutter/material.dart';

class BaseConfigTile extends StatelessWidget {
  const BaseConfigTile({
    @required this.label,
    @required this.icon,
    this.trailingWidth = 140,
    this.onTap,
    this.trailing,
    Key key, this.onLongPress,
  }) : super(key: key);

  final String label;
  final Icon icon;
  final Widget trailing;
  final double trailingWidth;
  final VoidCallback onTap, onLongPress;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      onLongPress: onLongPress,
      leading: icon,
      title: Text(label),
      trailing: SizedBox(
        child: trailing,
        width: trailingWidth,
      ),
    );
  }
}
