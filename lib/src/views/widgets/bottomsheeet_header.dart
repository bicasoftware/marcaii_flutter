import 'package:flutter/material.dart';
import 'package:flutter_utils/context_helper.dart';
import 'package:marcaii_flutter/src/views/widgets/light_container.dart';

class BottomsheetHeader extends StatelessWidget {
  const BottomsheetHeader({
    @required this.title,
    @required this.onPressed,
    @required this.icon,
    this.dividerPadding = 16,
    this.hasDivider = true,
    Key key,
  }) : super(key: key);

  final String title;
  // final IconButton action;
  final bool hasDivider;
  final double dividerPadding;
  final VoidCallback onPressed;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 16, right: 8, top: 8, bottom: 8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                flex: 6,
                child: Text(
                  title,
                  style: context.textTheme.subtitle1,
                ),
              ),
              LightContainer(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                child: IconButton(
                  icon: icon,
                  onPressed: onPressed,
                ),
              )
            ],
          ),
        ),
        hasDivider
            ? Divider(
                indent: dividerPadding ?? 0,
                endIndent: dividerPadding ?? 0,
                height: 0,
              )
            : Container(),
      ],
    );
  }
}
