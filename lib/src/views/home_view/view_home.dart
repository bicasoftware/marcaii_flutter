import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_emprego.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_main.dart';
import 'package:marcaii_flutter/src/views/home_view/view_home_drawer.dart';
import 'package:marcaii_flutter/src/views/view_calendario/view_calendario.dart';
import 'package:marcaii_flutter/src/views/view_empregos/view_empregos.dart';
import 'package:marcaii_flutter/src/views/view_totais/view_totais.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:provider/provider.dart';

class ViewHome extends StatefulWidget {
  const ViewHome();

  @override
  _ViewHomeState createState() => _ViewHomeState();
}

class _ViewHomeState extends State<ViewHome> with SingleTickerProviderStateMixin {
  void onAddEmprego() {
    Navigator.of(context).push<MaterialPageRoute<dynamic>>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => ViewEmpregos(),
      ),
    );
  }

  void onNewEmprego(BlocMain b) async {
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
  }

  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocMain>(context);

    return StreamObserver<int>(
      stream: b.outNavPosition,
      onSuccess: (_, int pos) {
        return Scaffold(
          appBar: AppBar(
            title: Text(Consts.appBarTitles[pos]),
            elevation: 1,
          ),
          drawer: ViewHomeDrawer(
            onNewEmprego: () => onNewEmprego(b),
          ),
          body: const ViewCalendario(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
            elevation: 2,
            label: Text(Strings.verTotais),
            icon: Icon(LineAwesomeIcons.money),
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
        );
      },
    );
  }
}
