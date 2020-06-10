import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_emprego.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_main.dart';
import 'package:marcaii_flutter/src/views/view_empregos/view_empregos.dart';

mixin ViewHomePresenter<T extends StatefulWidget> {
  void onNewEmprego() async {
    final b = Get.find<BlocMain>();
    Get.put<BlocEmprego>(BlocEmprego(emprego: Empregos()));
    final result = await Get.to<Empregos>(ViewEmpregos(), arguments: Empregos());

    if (result != null && result is Empregos) {
      b.addEmprego(result);
    }
  }
}
