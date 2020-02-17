import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:marcaii_flutter/strings.dart';

class ViewHomeBottombar extends StatelessWidget {
  const ViewHomeBottombar({
    @required this.pos,
    @required this.onTapped,
    Key key,
  }) : super(key: key);

  final int pos;
  final void Function(int) onTapped;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTapped,
      currentIndex: pos,
      items: [
        BottomNavigationBarItem(
          icon: Icon(LineAwesomeIcons.calendar),
          title: const Text(Strings.calendario),
        ),
        BottomNavigationBarItem(
          icon: Icon(LineAwesomeIcons.list),
          title: const Text(Strings.parciais),
        ),
      ],
    );
  }
}
