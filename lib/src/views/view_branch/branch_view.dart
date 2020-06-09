import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_main.dart';
import 'package:marcaii_flutter/src/utils/vault.dart';
import 'package:marcaii_flutter/src/views/view_home/view_home.dart';
import 'package:marcaii_flutter/src/views/view_presentation/view_presentation.dart';

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
  int position;
  List<Empregos> empregos;

  @override
  void initState() {
    super.initState();
    empregos = widget.empregos;
    empregos.isEmpty ? position = 0 : position = 1;
  }

  void onAllSet(List<Empregos> empregos) {
    setState(() {
      position = 1;
      this.empregos = empregos;
    });
  }

  Widget getActualView() {
    if (position == 0) {
      return ViewPresentation(onAllSet: onAllSet);
    } else {
      Get.put(
        BlocMain(empregos),
      );
      return ViewHome();
    }
  }

  Future<String> findToken() async {
    final manager = Vault();
    return manager.getToken();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      child: getActualView(),
      duration: const Duration(milliseconds: 400),
    );
  }
}
