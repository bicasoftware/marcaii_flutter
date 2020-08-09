import 'package:flutter/material.dart';

class TextDescricaoItem extends StatelessWidget {
  const TextDescricaoItem({
    @required this.label,
    this.maxLines = 3,
    Key key,
  }) : super(key: key);
  final String label;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        label,
        maxLines: maxLines,
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }
}
