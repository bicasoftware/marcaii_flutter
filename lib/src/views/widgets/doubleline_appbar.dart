import 'package:flutter/material.dart';

class DoubleLineAppbar extends StatelessWidget with PreferredSizeWidget {
  DoubleLineAppbar({
    @required this.title,
    @required this.subtitle,
    this.backgroundColor,
    this.elevation,
    this.actions,
    this.bottom,
    Key key,
  }) : super(key: key);

  final Color backgroundColor;
  final String title, subtitle;
  final double elevation;
  final List<Widget> actions;
  final PreferredSizeWidget bottom;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(

      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: theme.textTheme.headline6.copyWith(fontWeight: FontWeight.normal),
          ),
          Text(
            subtitle,
            style: theme.textTheme.caption.copyWith(color: Colors.black45),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      elevation: elevation ?? 2,
      actions: actions,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}