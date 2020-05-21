import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_main.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:provider/provider.dart';

class ViewHomePresenter {
  ViewHomePresenter(this.context);

  final BuildContext context;

  void onNewEmprego() async {
    final b = Provider.of<BlocMain>(context, listen: false);

    final result = await Navigator.of(context).pushNamed(
      Routes.routeEmpregos,
      arguments: const Empregos(),
    );

    if (result != null && result is Empregos) {
      b.addEmprego(result);
    }
  }
}
