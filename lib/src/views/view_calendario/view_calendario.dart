import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_main.dart';
import 'package:marcaii_flutter/src/state/calendario_child.dart';
import 'package:marcaii_flutter/src/utils/dialogs/dialogs.dart';
import 'package:marcaii_flutter/src/utils/vigencia.dart';
import 'package:marcaii_flutter/src/views/view_calendario/bts_horas_info/bts_horas_info.dart';
import 'package:marcaii_flutter/src/views/view_calendario/calendario/calendario_header.dart';
import 'package:marcaii_flutter/src/views/view_calendario/calendario/calendario_page.dart';
import 'package:marcaii_flutter/src/views/view_calendario/calendario_navigator.dart';
import 'package:marcaii_flutter/src/views/view_calendario/view_get_horas/view_insert_horas.dart';
import 'package:provider/provider.dart';

//TODO - Ao remover Emprego, dá tela vermelha, erro de index
//TODO - Verificar se está removendo as horas, salarios, diferenciais ao remover o emprego

class ViewCalendario extends StatefulWidget {
  const ViewCalendario({
    @required this.empregos,
    @required this.vigencia,
    @required this.index,
    Key key,
  }) : super(key: key);

  final List<Empregos> empregos;
  final Vigencia vigencia;
  final int index;

  @override
  _ViewCalendarioState createState() => _ViewCalendarioState();
}

class _ViewCalendarioState extends State<ViewCalendario> with TickerProviderStateMixin {
  TabController controller;

  Future<Horas> showViewGetHoras({
    @required BuildContext context,
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

  Future<bool> showViewInfoHoras({
    @required BuildContext context,
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

  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocMain>(context);
    final theme = Theme.of(context);

    controller = TabController(
      vsync: this,
      initialIndex: widget.index,
      length: widget.empregos.length,
    )..addListener(() {
        if (!controller.indexIsChanging) {
          b.setNavPosition(controller.index);
        }
      });

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        CalendarioNavigator(),
        const Divider(height: 0, indent: 16, endIndent: 16),
        if (widget.empregos.length > 1)
          TabBar(
            controller: controller,
            labelColor: theme.accentColor,
            unselectedLabelColor: theme.primaryColorLight,
            tabs: widget.empregos.map((e) {
              return Tab(
                child: AutoSizeText(
                  e.nome,
                  maxLines: 1,
                ),
              );
            }).toList(),
          ),
        CalendarioHeader(),
        const Divider(height: 0, indent: 16, endIndent: 16),
        Expanded(
          child: TabBarView(
            controller: controller,
            children: [
              for (final e in widget.empregos)
                CalendarioPage(
                  emprego: e,
                  onItemTap: (CalendarioChild child) async {
                    if (child.hora == null) {
                      final hora = await showViewGetHoras(
                        context: context,
                        emprego: e,
                        date: child.date,
                      );
                      if (hora != null && hora is Horas) {
                        b.addHora(hora, widget.vigencia);
                      }
                    } else {
                      final canDelete = await showViewInfoHoras(
                        context: context,
                        emprego: e,
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
                          b.removeHora(hora: child.hora, emprego_id: e.id);
                        }
                      }
                    }
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }
}
