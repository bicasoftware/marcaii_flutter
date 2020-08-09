import 'package:flutter/material.dart';
import 'package:marcaii_flutter/strings.dart';

class PageLogo extends StatelessWidget {
  const PageLogo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.fitWidth,
            height: 200,
          ),
          Text(Strings.appName, style: theme.textTheme.headline4),
          Text("Para começar, me fale mais sobre seu trabalho...", style: theme.textTheme.caption),
        ],
      ),
    );
  }
}
