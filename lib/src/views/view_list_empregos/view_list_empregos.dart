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
    return Expanded(
      child: StreamObserver<List<Empregos>>(
        stream: b.empregos,
        onSuccess: (_, empregos) {
          return ListView.separated(
              itemCount: empregos.length,
              padding: EdgeInsets.zero,
              separatorBuilder: (_, i) => const Divider(height: 0, indent: 16, endIndent: 16),
              itemBuilder: (_, i) {
                final e = empregos[i];
                return ViewListEmpregosItem(
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
                );
              }
              /* children: [
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
            ], */
              );
        },
      ),
    );
  }
}
