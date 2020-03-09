import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_main.dart';
import 'package:marcaii_flutter/src/views/home_view/view_home_btb.dart';
import 'package:marcaii_flutter/src/views/view_calendario/view_calendario.dart';
import 'package:marcaii_flutter/src/views/view_empregos/view_empregos.dart';
import 'package:marcaii_flutter/src/views/view_list_empregos/view_list_empregos.dart';
import 'package:marcaii_flutter/src/views/view_parciais/view_parciais.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:provider/provider.dart';

class ViewHome extends StatefulWidget {
  const ViewHome();

  @override
  _ViewHomeState createState() => _ViewHomeState();
}

class _ViewHomeState extends State<ViewHome> with SingleTickerProviderStateMixin {
  // int pos;
  // TabController controller;

  final pages = <Widget>[
    ViewListEmpregos(),
    const ViewCalendario(),
    const ViewParciais(),
  ];

  @override
  void initState() {
    // pos = 0;
    // controller = TabController(
    //   vsync: this,
    //   initialIndex: pos,
    //   length: pages.length,
    // );
    super.initState();
  }

/*   setPos(int pos) {
    setState(() => this.pos = pos);
  } */

  onAddEmprego() {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => ViewEmpregos(),
      ),
    );
  }

  onUserOptionChange(int pos) {}

  onEmpregoTap(Empregos emprego) {}

  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocMain>(context);

    return StreamObserver<int>(
      stream: b.outNavPosition,
      onSuccess: (_, int pos) {
        return Scaffold(
          appBar: AppBar(
            title: Text(Consts.appBarTitles[pos]),
            elevation: 1,
          ),
          bottomNavigationBar: ViewHomeBottombar(
            onTapped: b.setNavPosition,
            pos: pos,
          ),
          body: PageTransitionSwitcher(
            transitionBuilder: (
              Widget child,
              Animation<double> anim1,
              Animation<double> anim2,
            ) {
              return FadeThroughTransition(
                child: child,
                animation: anim1,
                secondaryAnimation: anim2,
              );
            },
            child: pages[pos],
          ),
        );
      },
    );
  }
}
