import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_main.dart';
import 'package:marcaii_flutter/src/state/calendario_item.dart';
import 'package:marcaii_flutter/src/utils/dialogs/dialogs.dart';
import 'package:marcaii_flutter/src/utils/vigencia.dart';
import 'package:marcaii_flutter/src/views/view_calendario/bts_horas_info/bts_horas_info.dart';
import 'package:marcaii_flutter/src/views/view_calendario/calendario/calendario_header.dart';
import 'package:marcaii_flutter/src/views/view_calendario/calendario/calendario_page.dart';
import 'package:marcaii_flutter/src/views/view_calendario/calendario_navigator.dart';
import 'package:marcaii_flutter/src/views/view_calendario/view_get_horas/view_insert_horas.dart';
import 'package:marcaii_flutter/src/views/view_parciais/view_parciais.dart';
import 'package:provider/provider.dart';

class ViewCalendario extends StatefulWidget {
  const ViewCalendario({Key key}) : super(key: key);

  @override
  _ViewCalendarioState createState() => _ViewCalendarioState();
}

class _ViewCalendarioState extends State<ViewCalendario> {
  Future<Horas> showViewGetHoras({@required Empregos emprego, @required DateTime date}) async {
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

  Future<bool> showViewInfoHoras({Empregos emprego, CalendarioChild child}) async {
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

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        MergedStreamObserver(
          streams: [b.empregos, b.outVigencia],
          onSuccess: (BuildContext context, List<Object> data) {
            final empregos = data[0] as List<Empregos>;
            final vigencia = data[1] as Vigencia;

            return DefaultTabController(
              length: empregos.length,
              initialIndex: 0,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  CalendarioNavigator(),
                  const Divider(height: 0, indent: 16, endIndent: 16),
                  if (empregos.length > 1)
                    TabBar(
                      labelColor: theme.accentColor,
                      unselectedLabelColor: theme.primaryColorLight,
                      tabs: empregos.map((e) {
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
                      children: [
                        for (final e in empregos)
                          CalendarioPage(
                            emprego: e,
                            onItemTap: (CalendarioChild child) async {
                              if (child.hora == null) {
                                final hora = await showViewGetHoras(emprego: e, date: child.date);
                                if (hora != null && hora is Horas) {
                                  b.addHora(hora, vigencia);
                                }
                              } else {
                                final canDelete = await showViewInfoHoras(emprego: e, child: child);
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
              ),
            );
          },
        ),
        Positioned(
          right: 16,
          bottom: 16,
          child: FloatingActionButton(
            child: Icon(LineAwesomeIcons.file_text),
            onPressed: () {
              //TODO - Listar todas as horas da vigência, (fechamento+1 e mes -1)
              //TODO - gerar model e passar para ViewParciais
              //TODO - Implementar layout da tela de parciais, com totalizador e gerador de arquivos
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (_) => const ViewParciais(),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
