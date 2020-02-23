import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_main.dart';
import 'package:marcaii_flutter/src/views/home_view/view_home_btb.dart';
import 'package:marcaii_flutter/src/views/view_calendario/view_calendario.dart';
import 'package:marcaii_flutter/src/views/view_empregos/view_empregos.dart';
import 'package:marcaii_flutter/src/views/view_list_empregos/view_list_empregos.dart';
import 'package:marcaii_flutter/src/views/view_parciais/view_parciais.dart';
import 'package:provider/provider.dart';

class ViewHome extends StatefulWidget {
  const ViewHome();

  @override
  _ViewHomeState createState() => _ViewHomeState();
}

class _ViewHomeState extends State<ViewHome> with SingleTickerProviderStateMixin {
  int pos;
  TabController controller;

  final pages = [
    ViewListEmpregos(),
    const ViewCalendario(),
    const ViewParciais(),
  ];

  @override
  void initState() {
    pos = 0;
    controller = TabController(
      vsync: this,
      initialIndex: pos,
      length: pages.length,
    );
    super.initState();
  }

  setPos(int pos) {
    setState(() => this.pos = pos);
  }

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

    return Scaffold(
      appBar: AppBar(
        title: StreamObserver<String>(
          stream: b.outAppbarTitle,
          onSuccess: (BuildContext context, String title) {
            return Text(title);
          },
        ),
        elevation: 1,
      ),
      bottomNavigationBar: StreamObserver<int>(
        stream: b.outNavPosition,
        onSuccess: (_, p) {
          return ViewHomeBottombar(
            onTapped: (pos) {
              controller.animateTo(pos);
              b.setNavPosition(pos);
            },
            pos: p,
          );
        },
      ),
      body: TabBarView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: pages,
      ),
    );
  }
}
