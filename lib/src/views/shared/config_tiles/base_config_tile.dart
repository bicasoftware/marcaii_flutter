import 'package:flutter/material.dart';

class BaseConfigTile extends StatelessWidget {
  const BaseConfigTile({
    @required this.label,
    @required this.icon,
    this.trailingWidth = 140,
    this.onTap,
    this.trailing,
    Key key,
  }) : super(key: key);

  final String label;
  final Icon icon;
  final Widget trailing;
  final double trailingWidth;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: icon,
      title: Text(this.label),
      trailing: SizedBox(
        child: trailing,
        width: trailingWidth,
      ),
    );
  }
}
