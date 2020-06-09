import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_main.dart';
import 'package:marcaii_flutter/src/views/view_empregos/view_empregos.dart';

class ViewHomePresenter {
  ViewHomePresenter(this.context);

  final BuildContext context;

  void onNewEmprego() async {
    final b = Get.find<BlocMain>();

    final result = await Get.to<Empregos>(ViewEmpregos(), arguments: Empregos());

    if (result != null && result is Empregos) {
      b.addEmprego(result);
    }
  }
}
