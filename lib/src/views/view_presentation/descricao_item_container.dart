import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class PresentationItemContainer extends StatelessWidget {
  const PresentationItemContainer({
    @required this.title,
    @required this.descricao,
    @required this.widget,
    @required this.asset,
    Key key,
  }) : super(key: key);
  final String title, descricao, asset;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final height = MediaQuery.of(context).size.height;
    final actualHeight = height - kToolbarHeight - 56;

    return SingleChildScrollView(
      child: SizedBox(
        //altura da view é o tamanho da tela, menos altura do toolbar menos a altura do container com os botões de next/prev
        height: actualHeight,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: AutoSizeText(title, style: theme.textTheme.headline4),
              ),
            ),
            Expanded(
              flex: 4,
              child: Image.asset(
                asset,
                fit: BoxFit.fitWidth,
                height: 150,
              ),
            ),
            const SizedBox(height: 16),
            widget,
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(descricao, style: theme.textTheme.caption),
            )
          ],
        ),
      ),
    );
  }
}
