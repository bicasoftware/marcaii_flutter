import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lib_observer/stream_observer.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_main.dart';
import 'package:marcaii_flutter/src/state/calendario_item.dart';
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
  void showViewGetHoras({@required Empregos emprego, @required DateTime date}) async {
    
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => ViewInsertHoras(
          emprego: emprego,
          data: date,
        ),
      ),
    );

    print(result);

    print("show view get horas");
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

    return StreamObserver<List<Empregos>>(
      stream: b.empregos,
      onError: (_, e) {
        return Container(
          color: Colors.red,
          width: double.maxFinite,
          height: double.maxFinite,
        );
      },
      onSuccess: (BuildContext context, List<Empregos> empregos) {
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
                        onItemTap: (CalendarioChild child) {
                          if (child.hora == null) {
                            showViewGetHoras(emprego: e, date: child.date);
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
