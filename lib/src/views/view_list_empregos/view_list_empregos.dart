import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_main.dart';
import 'package:marcaii_flutter/src/views/widgets/dialogs.dart';
import 'package:marcaii_flutter/src/views/view_list_empregos/view_list_empregos_item.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:provider/provider.dart';

class ViewListEmpregos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocMain>(context);
    return Expanded(
      child: StreamObserver<List<Empregos>>(
        stream: b.empregos,
        onSuccess: (_, List<Empregos> empregos) {
          return ListView.builder(
            itemCount: empregos.length,
            padding: EdgeInsets.zero,
            itemBuilder: (_, i) {
              final e = empregos[i];
              return ViewListEmpregosItem(
                emprego: e,
                onDelete: (Empregos emprego) async {
                  final r = await showConfirmationDialog(
                      context: context,
                      title: Strings.removerEmprego,
                      message: Strings.removerEmpregoMessage);
                  if (r) {
                    b.removeEmprego(emprego);
                  }
                },
                onPressed: (Empregos emprego, GlobalKey itemKey) async {
                  final result = await Navigator.of(context).pushNamed<Object>(
                    Routes.routeEmpregos,
                    arguments: emprego,
                  );

                  if (result != null && result is Empregos) {
                    b.updateEmprego(result);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
