import 'package:auto_size_text/auto_size_text.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:marcaii_flutter/strings.dart';

class ViewTotaisBottombar extends StatelessWidget {
  const ViewTotaisBottombar({
    @required this.pos,
    @required this.onTap,
    @required this.hasDifer,
    Key key,
  }) : super(key: key);

  final int pos;
  final bool hasDifer;
  final Function(int p) onTap;

  @override
  Widget build(BuildContext context) {
    //TODO - repassar tabbar
    return BubbleBottomBar(
      currentIndex: pos,
      opacity: .2,
      onTap: onTap,
      elevation: 2,
      items: <BubbleBottomBarItem>[
        _BottomBarItem(
          color: Consts.horaColor[0],
          title: Consts.tipoHoraPlural[0],
        ).build(),
        _BottomBarItem(
          color: Consts.horaColor[1],
          title: Consts.tipoHoraPlural[1],
        ).build(),
        if (hasDifer)
          _BottomBarItem(
            color: Consts.horaColor[2],
            title: Consts.tipoHoraPlural[2],
          ).build(),
        _BottomBarItem(
          color: Consts.horaColor[3],
          title: Consts.tipoHoraPlural[3],
        ).build()
      ],
    );
  }
}

class _BottomBarItem {
  const _BottomBarItem({this.color, this.title});

  final Color color;
  final String title;

  BubbleBottomBarItem build() {
    return BubbleBottomBarItem(

      backgroundColor: color,
      icon: Icon(
        Icons.view_compact,
        color: color,
      ),
      activeIcon: Icon(Icons.view_compact),
      title: AutoSizeText(
        title,
        maxLines: 1,
        maxFontSize: 16,
      ),
    );
  }
}
