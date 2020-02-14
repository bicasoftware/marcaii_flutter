import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/views/home_view/view_home_btb.dart';
import 'package:marcaii_flutter/src/views/home_view/view_home_drawer.dart';
import 'package:marcaii_flutter/src/views/view_calendario/view_calendario.dart';
import 'package:marcaii_flutter/src/views/view_empregos/view_empregos.dart';
import 'package:marcaii_flutter/src/views/view_parciais/view_parciais.dart';
import 'package:morpheus/widgets/morpheus_tab_view.dart';

class ViewHome extends StatefulWidget {
  const ViewHome();

  @override
  _ViewHomeState createState() => _ViewHomeState();
}

class _ViewHomeState extends State<ViewHome> {
  int pos;

  final pages = const [
    ViewCalendario(),
    ViewParciais(),
  ];

  @override
  void initState() {
    pos = 0;
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        elevation: 1,
      ),
      drawer: ViewHomeDrawer(
        onAddTapped: onAddEmprego,
        onChanged: onUserOptionChange,
        onEmpregoTap: onEmpregoTap,
      ),
      bottomNavigationBar: ViewHomeBottombar(
        onTapped: setPos,
        pos: pos,
      ),
      body: MorpheusTabView(
        child: pages[pos],
      ),
    );
  }
}
