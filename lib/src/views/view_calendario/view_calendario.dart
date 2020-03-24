import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_main.dart';
import 'package:marcaii_flutter/src/state/calendario_item.dart';
import 'package:marcaii_flutter/src/utils/vigencia.dart';
import 'package:marcaii_flutter/src/views/view_calendario/calendario/calendario_header.dart';
import 'package:marcaii_flutter/src/views/view_calendario/calendario/calendario_page.dart';
import 'package:marcaii_flutter/src/views/view_calendario/calendario_navigator.dart';
import 'package:marcaii_flutter/src/views/view_calendario/view_get_horas/view_insert_horas.dart';
import 'package:provider/provider.dart';

class ViewCalendario extends StatefulWidget {
  const ViewCalendario({Key key}) : super(key: key);

  @override
  _ViewCalendarioState createState() => _ViewCalendarioState();
}

class _ViewCalendarioState extends State<ViewCalendario>
    with AutomaticKeepAliveClientMixin<ViewCalendario> {
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

  void showViewInfoHoras({Empregos empregos, CalendarioChild child}) {
    print("info horas");
    //TODO: Mostrar bottomsheet com informações da hora extra
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final b = Provider.of<BlocMain>(context);
    final theme = Theme.of(context);

    return MergedStreamObserver(
      streams: [b.empregos, b.outVigencia],
      onError: (_, e) {
        return Container(
          color: Colors.red,
          width: double.maxFinite,
          height: double.maxFinite,
        );
      },
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
                            showViewInfoHoras(empregos: e, child: child);
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}
