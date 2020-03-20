import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_emprego.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_main.dart';
import 'package:marcaii_flutter/src/views/view_empregos/view_empregos.dart';
import 'package:marcaii_flutter/src/views/view_list_empregos/view_list_empregos_item.dart';
import 'package:provider/provider.dart';

class ViewListEmpregos extends StatefulWidget {
  @override
  _ViewListEmpregosState createState() => _ViewListEmpregosState();
}

class _ViewListEmpregosState extends State<ViewListEmpregos> {
  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocMain>(context);

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          child: StreamObserver<List<Empregos>>(
            stream: b.empregos,
            onSuccess: (_, empregos) {
              return ListView(
                shrinkWrap: true,
                children: [
                  for (final e in empregos)
                    ViewListEmpregosItem(
                      emprego: e,
                      onDelete: b.removeEmprego,
                      onPressed: (Empregos emprego, GlobalKey itemKey) async {
                        final result = await Navigator.of(context).push(
                          MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (BuildContext context) {
                              return Provider<BlocEmprego>(
                                create: (_) => BlocEmprego(
                                  emprego: emprego,
                                  isCreating: false,
                                ),
                                dispose: (_, b) => b.dispose(),
                                child: ViewEmpregos(),
                              );
                            },
                          ),
                        );

                        if (result != null && result is Empregos) {
                          b.updateEmprego(result);
                        }
                      },
                    ),
                ],
              );
            },
          ),
        ),
        Positioned(
          right: 16,
          bottom: 16,
          child: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              final result = await Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (_) {
                    return Provider<BlocEmprego>(
                      create: (BuildContext context) => BlocEmprego(
                        emprego: const Empregos(),
                        isCreating: true,
                      ),
                      dispose: (_, b) => b.dispose(),
                      child: ViewEmpregos(),
                    );
                  },
                ),
              );

              if (result != null && result is Empregos) {
                b.addEmprego(result);
              }
            },
          ),
        ),
      ],
    );
  }
}
