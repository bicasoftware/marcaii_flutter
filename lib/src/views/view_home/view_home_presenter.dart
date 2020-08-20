import 'package:flutter/material.dart';
import 'package:marcaii_flutter/context_helper.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_main.dart';
import 'package:marcaii_flutter/src/views/view_empregos/view_empregos.dart';
import 'package:provider/provider.dart';

mixin ViewHomePresenter<T extends StatefulWidget> {
  void onNewEmprego(BuildContext context) async {
    final b = Provider.of<BlocMain>(context);

    final result = await context.navigate<Empregos>(
      ViewEmpregos(),
      arguments: Empregos(),
    );

    if (result != null && result is Empregos) {
      b.addEmprego(result);
    }
  }
}
