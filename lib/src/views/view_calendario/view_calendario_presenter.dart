import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_main.dart';
import 'package:marcaii_flutter/src/state/calendario/calendario_child.dart';
import 'package:marcaii_flutter/src/utils/dialogs/dialogs.dart';
import 'package:marcaii_flutter/src/utils/vigencia.dart';
import 'package:marcaii_flutter/src/views/view_calendario/bts_horas_info/bts_horas_info.dart';
import 'package:marcaii_flutter/src/views/view_calendario/view_get_horas/view_insert_horas.dart';
import 'package:provider/provider.dart';

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

  Future<Horas> showViewGetHoras({
    @required Empregos emprego,
    @required DateTime date,
  }) async {
    return await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => ViewInsertHoras(
          emprego: emprego,
          data: date,
        ),
      ),
    );
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
    CalendarioChild child,
    Empregos emprego,
    Vigencia vigencia,
  }) async {
    final b = Provider.of<BlocMain>(context, listen: false);
    if (child.hora == null) {
      final hora = await showViewGetHoras(
        emprego: emprego,
        date: child.date,
      );
      if (hora != null && hora is Horas) {
        b.addHora(hora, vigencia);
      }
    } else {
      final canDelete = await showViewInfoHoras(
        emprego: emprego,
        child: child,
      );
      if (canDelete) {
        final confirmRemove = await showConfirmationDialog(
          context: context,
          title: "Exclusão",
          message: "Deseja apagar a hora extra?",
          negativeCaption: "Cancelar",
          positiveCaption: "Apagar!",
        );

        if (confirmRemove == true) {
          b.removeHora(hora: child.hora, emprego_id: emprego.id);
        }
      }
    }
  }
}
