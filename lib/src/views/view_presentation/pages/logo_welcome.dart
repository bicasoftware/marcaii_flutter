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
          Text("O Marcaii é um organizador de horas extras. Com ele você poderá adicionar, remover e ficar ligado em quantas horas você fez e quanto vai receber no mês seguinte.",
              style: theme.textTheme.caption.copyWith(fontWeight: FontWeight.bold)),
          Text(
            'Arrasta pro lado e vamos começar!',
            style: theme.textTheme.caption,
          )
        ],
      ),
    );
  }
}
