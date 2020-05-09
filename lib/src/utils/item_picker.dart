import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';

class ItemPicker<T> extends StatefulWidget {
  const ItemPicker({
    @required this.items,
    @required this.onCentered,
    @required this.initValue,
    this.backgroundColor = Colors.transparent,
    this.textColor,
    this.doLoop = true,
    Key key,
  }) : super(key: key);

  final List<T> items;
  final T initValue;
  final Function(int pos) onCentered;
  final bool doLoop;
  final Color backgroundColor, textColor;

  @override
  _ItemPickerState createState() => _ItemPickerState();
}

class _ItemPickerState<T> extends State<ItemPicker> {
  int pos;

  int get _getIndex => widget.items.indexOf(widget.initValue);

  ScrollController controller;

  @override
  void initState() {
    pos = _getIndex;
    controller = FixedExtentScrollController(initialItem: pos);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 80,
      child: CupertinoPicker(
        scrollController: controller,
        backgroundColor: widget.backgroundColor,
        looping: widget.doLoop,
        children: <Widget>[
          for (final item in widget.items)
            Text(
              item.toString(),
              style: theme.textTheme.headline6,
            )
        ],
        onSelectedItemChanged: (int pos) {
          widget.onCentered(pos);
        },
        itemExtent: 24,
      ),
    );
  }
}
