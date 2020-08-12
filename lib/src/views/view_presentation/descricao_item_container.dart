import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/views/widgets/light_container.dart';

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

    return LightContainer(
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: SizedBox(
          height: actualHeight,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: AutoSizeText(title, style: theme.textTheme.headline5),
              ),
              Image.asset(
                asset,
                fit: BoxFit.contain,
                height: 200,
                width: 200,
              ),
              const Spacer(),
              const SizedBox(height: 8),
              widget,
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(descricao, style: theme.textTheme.caption.copyWith(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
