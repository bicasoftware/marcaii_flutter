import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/views/view_presentation/text_descricao_item.dart';

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
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        Text(title, style: theme.textTheme.headline4),
        const SizedBox(height: 16),
        Card(
          child: Column(
            children: <Widget>[
              Image.asset(
                asset,
                fit: BoxFit.fitWidth,
                height: 200,
              ),
              const SizedBox(height: 8),
              widget,
            ],
          ),
        ),
        const Spacer(),
        TextDescricaoItem(label: descricao),
      ],
    );
  }
}
