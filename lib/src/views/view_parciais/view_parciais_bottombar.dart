import 'package:auto_size_text/auto_size_text.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:marcaii_flutter/strings.dart';

class ViewParciaisBottombar extends StatelessWidget {
  const ViewParciaisBottombar({Key key, this.pos, this.onTap}) : super(key: key);

  final int pos;
  final Function(int p) onTap;

  static const tabLenght = 4;

  @override
  Widget build(BuildContext context) {
    return BubbleBottomBar(
      currentIndex: pos,
      opacity: .2,
      onTap: onTap,
      elevation: 2,
      items: <BubbleBottomBarItem>[
        for (int i = 0; i < tabLenght; i++)
          BubbleBottomBarItem(
            backgroundColor: Consts.horaColor[i],
            icon: Icon(
              Icons.view_compact,
              color: Consts.horaColor[i],
            ),
            activeIcon: Icon(Icons.view_compact),
            title: AutoSizeText(
              Consts.tipoHoraPlural[i],
              maxLines: 1,
              maxFontSize: 16,
            ),
          ),
      ],
    );
  }
}
