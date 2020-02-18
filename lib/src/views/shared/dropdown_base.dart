import 'package:flutter/material.dart';

class DropDownBase<T> extends StatefulWidget {
  const DropDownBase({
    @required this.items,
    @required this.initialValue,
    @required this.onChanged,
    this.formatter,
    Key key,
  }) : super(key: key);

  final List<T> items;
  final T initialValue;
  final Function(T value) formatter;
  final Function(T value) onChanged;

  @override
  _DropDownBaseState createState() => _DropDownBaseState<T>();
}

class _DropDownBaseState<T> extends State<DropDownBase> {
  T _value;

  @override
  void initState() {
    _value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      value: _value,
      items: <DropdownMenuItem<T>>[
        for (final item in widget.items)
          DropdownMenuItem<T>(
            value: item,
            child: Text(
              widget.formatter != null ? widget.formatter(item) : item.toString(),
            ),
          )
      ],
      onChanged: (T value) {
        setState(() => _value = value);
        widget.onChanged(value);
      },
    );
  }
}
