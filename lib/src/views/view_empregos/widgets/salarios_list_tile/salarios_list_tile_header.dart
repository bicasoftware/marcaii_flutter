import 'package:flutter/material.dart';
import 'package:marcaii_flutter/strings.dart';

class SalariosListTileHeader extends StatelessWidget {
  const SalariosListTileHeader({
    @required this.onAddTap,
    Key key,
  }) : super(key: key);
  final VoidCallback onAddTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Divider(height: 0),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  Strings.salarios,
                  style: theme.textTheme.subhead.copyWith(color: theme.accentColor),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: Icon(Icons.add),
                onPressed: onAddTap,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
