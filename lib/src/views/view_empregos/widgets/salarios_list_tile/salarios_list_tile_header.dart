import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/views/view_empregos/widgets/list_section_decorator.dart';
import 'package:marcaii_flutter/strings.dart';

class SalariosListTileHeader extends StatelessWidget {
  const SalariosListTileHeader({
    @required this.onAddTap,
    Key key,
  }) : super(key: key);
  final VoidCallback onAddTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        const Expanded(
          child: ListSectionDecorator(label: Strings.salarios),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            icon: const Icon(Icons.add),
            onPressed: onAddTap,
          ),
        ),
      ],
    );
  }
}
