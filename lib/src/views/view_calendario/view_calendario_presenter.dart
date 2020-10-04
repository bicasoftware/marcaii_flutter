import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_utils/flutter_utils.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/src/views/view_calendario/models/calendario_child.dart';
import 'package:marcaii_flutter/src/utils/vigencia.dart';
import 'package:marcaii_flutter/src/views/view_calendario/bts_horas_info/bts_horas_info.dart';
import 'package:marcaii_flutter/src/views/view_calendario/view_get_horas/view_insert_horas.dart';

class ViewCalendarioPresenter {
  ViewCalendarioPresenter(this.context);

  final BuildContext context;

  List<Tab> generateTabs(List<Empregos> empregos) {
    return <Tab>[
      for (final e in empregos)
        Tab(
          child: AutoSizeText(e.nome, maxLines: 1),
        )
    ];
  }

  Future<bool> showViewInfoHoras({
    Empregos emprego,
    CalendarioChild child,
  }) async {
    final bool shouldDelete = await showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      context: context,
      elevation: 2,
      builder: (_) => BtsHorasInfo(
        emprego: emprego,
        calendarioChild: child,
      ),
    );

    return shouldDelete ?? false;
  }

  TabController provideController({
    @required TickerProvider ticker,
    @required int initialIndex,
    @required int length,
  }) {
    return TabController(
      vsync: ticker,
      initialIndex: initialIndex,
      length: length,
    );
  }

  void onItemTap({
    @required void Function(Horas hora, Vigencia vigencia) onAddHora,
    @required void Function(Horas hora, int idEmprego) onRemoveHora,
    CalendarioChild child,
    Empregos emprego,
    Vigencia vigencia,
  }) async {
    if (child.hora == null) {
      final Horas hora = await showModalBottomSheet<Horas>(
        context: context,
        builder: (_) => ViewInsertHoras(emprego: emprego, data: child.date),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
      );
      if (hora != null && hora is Horas) {
        onAddHora(hora, vigencia);
      }
    } else {
      final canDelete = await showViewInfoHoras(
        emprego: emprego,
        child: child,
      );
      if (canDelete) {
        final confirmRemove = await Dialogs.showConfirmationDialog(
          context: context,
          title: "Exclusão",
          message: "Deseja apagar a hora extra?",
          negativeCaption: "Cancelar",
          positiveCaption: "Apagar!",
        );

        if (confirmRemove == true) {
          onRemoveHora(child.hora, emprego.id);
        }
      }
    }
  }
}
