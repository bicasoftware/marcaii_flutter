import 'package:flutter/material.dart';
import 'package:lib_observer/stream_observer.dart';
import 'package:marcaii_flutter/src/database/models/salarios.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_emprego.dart';
import 'package:marcaii_flutter/src/views/view_empregos/insert_salario/view_insert_salario.dart';
import 'package:marcaii_flutter/src/views/view_empregos/widgets/salarios_list_tile/salarios_list_item.dart';
import 'package:marcaii_flutter/src/views/view_empregos/widgets/salarios_list_tile/salarios_list_tile_header.dart';
import 'package:provider/provider.dart';

class SalariosListTile extends StatelessWidget {
  const SalariosListTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocEmprego>(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SalariosListTileHeader(
          onAddTap: () async {
            final result = await Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (_) => const ViewInsertSalario(isInsert: true),
              ),
            );

            if (result != null && result is Map<String, dynamic>) {
              b.addSalario(
                valor: result['valor'],
                vigencia: result['vigencia'],
              );
            }
          },
        ),
        StreamObserver<List<Salarios>>(
          stream: b.salarios,
          onSuccess: (BuildContext context, List salarios) {
            return Column(
              children: [
                for (final s in salarios)
                  SalariosListItem(
                    salario: s,
                    onDelete: b.deleteSalario,
                    onPressed: (Salarios s) async {
                      final r = await Navigator.of(context).push(
                        MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (_) => ViewInsertSalario(
                            isInsert: false,
                            salario: s.valor,
                            vigencia: s.vigencia,
                          ),
                        ),
                      );

                      if (r != null && r is Map<String, dynamic>) {
                        b.updateSalario(
                          salario: s,
                          vigencia: r['vigencia'],
                          valor: r['valor'],
                        );
                      }
                    },
                  )
              ],
            );
          },
        )
      ],
    );
  }
}
