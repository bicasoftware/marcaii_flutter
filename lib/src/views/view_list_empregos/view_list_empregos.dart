import 'package:flutter/material.dart';
import 'package:flutter_utils/async_widgets/async_widget.dart';
import 'package:flutter_utils/flutter_utils.dart';
import 'package:get/get.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_emprego.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_main.dart';
import 'package:marcaii_flutter/src/views/view_empregos/view_empregos.dart';
import 'package:marcaii_flutter/src/views/view_list_empregos/view_list_empregos_item.dart';
import 'package:marcaii_flutter/strings.dart';

class ViewListEmpregos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final b = Get.find<BlocMain>();
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
                  final r = await Dialogs.showConfirmationDialog(
                    context: context,
                    title: Strings.removerEmprego,
                    message: Strings.removerEmpregoMessage,
                  );
                  if (r) {
                    b.removeEmprego(emprego);
                  }
                },
                onPressed: (Empregos emprego, GlobalKey itemKey) async {
                  Get.put<BlocEmprego>(BlocEmprego(emprego: emprego.copyWith()));
                  final result = await Get.to<Empregos>(ViewEmpregos());
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
