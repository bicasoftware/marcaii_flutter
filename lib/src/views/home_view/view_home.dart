import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_emprego.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_main.dart';
import 'package:marcaii_flutter/src/utils/vigencia.dart';
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
    final theme = Theme.of(context);

    return MergedStreamObserver(
      streams: [b.empregos, b.outVigencia, b.outNavPosition],
      onSuccess: (BuildContext context, List<Object> data) {
        final empregos = data[0] as List<Empregos>;
        final vigencia = data[1] as Vigencia;
        final pos = data[2] as int;

        return Scaffold(
          appBar: AppBar(
            title: Text(Strings.calendario),
            elevation: 1,
          ),
          body: ViewCalendario(
            empregos: empregos,
            vigencia: vigencia,
            index: pos,
          ),
          drawer: ViewHomeDrawer(onNewEmprego: () => onNewEmprego(b)),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: OpenContainer(
            transitionDuration: const Duration(milliseconds: 400),
            closedColor: theme.accentColor,
            openColor: theme.canvasColor,
            closedShape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            transitionType: ContainerTransitionType.fadeThrough,
            openBuilder: (_, __) => ViewTotais(totais: empregos[pos].generateTotais(vigencia)),
            closedBuilder: (_, VoidCallback call) => FloatingActionButton(
              // label: Text(Strings.verTotais),
              child: Icon(LineAwesomeIcons.money),
              onPressed: call,
            ),
          ),
        );
      },
    );
  }
}
