import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_main.dart';
import 'package:marcaii_flutter/src/utils/vigencia.dart';
import 'package:marcaii_flutter/src/views/home_view/view_home_drawer.dart';
import 'package:marcaii_flutter/src/views/home_view/view_home_presenter.dart';
import 'package:marcaii_flutter/src/views/view_calendario/view_calendario.dart';
import 'package:marcaii_flutter/src/views/view_totais/view_totais.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:marcaii_flutter/helpers.dart';
import 'package:provider/provider.dart';

class ViewHome extends StatelessWidget {
  const ViewHome();

  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocMain>(context, listen: false);
    final presenter = ViewHomePresenter(context);
    final theme = Theme.of(context);

    return MergedStreamObserver(
      streams: [b.empregos, b.outVigencia, b.outNavPosition],
      onSuccess: (BuildContext context, List<Object> data) {
        final empregos = data[0] as List<Empregos>;
        final vigencia = data[1] as Vigencia;
        final pos = data[2] as int;

        return Scaffold(
          appBar: AppBar(
            title: const Text(Strings.calendario),
            elevation: 1,
          ),
          body: ViewCalendario(
            empregos: empregos,
            vigencia: vigencia,
            index: pos,
          ),
          drawer: ViewHomeDrawer(onNewEmprego: presenter.onNewEmprego),
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
