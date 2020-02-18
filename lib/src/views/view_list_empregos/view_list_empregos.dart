import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_main.dart';
import 'package:marcaii_flutter/src/views/view_empregos/view_empregos.dart';
import 'package:provider/provider.dart';

class ViewListEmpregos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocMain>(context);

    return Container(
      //TODO - implementar rotina para NOVO emprego
      padding: const EdgeInsets.all(8),
      child: StreamObserver<List<Empregos>>(
        stream: b.outEmpregos,
        onSuccess: (_, empregos) {
          return ListView(
            shrinkWrap: true,
            children: [              
              for (final e in empregos)
                ListTile(
                  leading: Icon(LineAwesomeIcons.suitcase),
                  title: Text(e.nome),
                  subtitle: Text("${e.carga_horaria} | ${e.saida} | ${e.fechamento}"),
                  trailing: IconButton(
                    icon: Icon(LineAwesomeIcons.remove),
                    onPressed: () {
                      //TODO - implementar rotina de exclusão de emprego!
                      print(e);
                    },
                  ),
                  onTap: () async {
                    ///TODO - aplicar [MorpheusPageRoute]
                    final result = await Navigator.of(context).push(
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (_) => ViewEmpregos(emprego: e),
                      ),
                    );

                    if (result != null && result is Empregos) {
                      //TODO - implementar atualização do emprego no bloc
                      print(result.nome);
                      result.diferenciadas.forEach(print);
                    }
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}
