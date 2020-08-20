import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_main.dart';
import 'package:marcaii_flutter/src/views/view_home/view_home.dart';
import 'package:marcaii_flutter/src/views/view_presentation/view_presentation.dart';
import 'package:provider/provider.dart';

class ViewBranch extends StatefulWidget {
  const ViewBranch({
    @required this.empregos,
    Key key,
  }) : super(key: key);
  final List<Empregos> empregos;

  @override
  _ViewBranchState createState() => _ViewBranchState();
}

class _ViewBranchState extends State<ViewBranch> {
  List<Empregos> empregos;
  int position;

  @override
  void initState() {
    super.initState();
    empregos = widget.empregos;
    position = empregos.length;
  }

  void onAllSet(List<Empregos> empregos) {
    setState(() {
      this.empregos = empregos;
      position = 1;
    });
  }

  Widget getActualView(List<Empregos> empregos) {
    if (position == 0) {
      return ViewPresentation(onAllSet: onAllSet);
    } else {
      return Provider<BlocMain>(
        dispose: (_, b) => b.dispose(),
        create: (_) => BlocMain(empregos),
        child: ViewHome(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      child: getActualView(empregos),
      duration: const Duration(milliseconds: 400),
    );
  }
}
