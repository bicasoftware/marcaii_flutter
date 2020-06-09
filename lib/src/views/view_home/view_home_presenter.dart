import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_main.dart';
import 'package:marcaii_flutter/strings.dart';

class ViewHomePresenter {
  ViewHomePresenter(this.context);

  final BuildContext context;

  void onNewEmprego() async {
    final b = Get.find<BlocMain>();

    final result = await Navigator.of(context).pushNamed(
      Routes.routeEmpregos,
      arguments: Empregos(),
    );

    if (result != null && result is Empregos) {
      b.addEmprego(result);
    }
  }
}
