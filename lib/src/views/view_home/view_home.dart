import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_utils/async_widgets/async_widget.dart';
import 'package:flutter_utils/flutter_utils.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:marcaii_flutter/context_helper.dart';
import 'package:marcaii_flutter/helpers.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_main.dart';
import 'package:marcaii_flutter/src/utils/vigencia.dart';
import 'package:marcaii_flutter/src/views/view_calendario/view_calendario.dart';
import 'package:marcaii_flutter/src/views/view_home/view_home_drawer.dart';
import 'package:marcaii_flutter/src/views/view_home/view_home_presenter.dart';
import 'package:marcaii_flutter/src/views/view_totais/view_totais.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:provider/provider.dart';

class ViewHome extends StatefulWidget {
  @override
  _ViewHomeState createState() => _ViewHomeState();
}

class _ViewHomeState extends State<ViewHome> with ViewHomePresenter {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<BlocMain>(context);

    return MergedStreamObserver(
      streams: [bloc.empregos, bloc.outVigencia, bloc.outNavPosition],
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
          drawer: ViewHomeDrawer(
            onNewEmprego: () => onNewEmprego(context),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: OpenContainer(
            transitionDuration: const Duration(milliseconds: 600),
            closedColor: context.theme.canvasColor,
            closedElevation: 0,
            openElevation: 0,
            openColor: context.theme.primaryColor,
            closedShape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            transitionType: ContainerTransitionType.fadeThrough,
            openBuilder: (_, __) => ViewTotais(totais: empregos[pos].generateTotais(vigencia)),
            closedBuilder: (_, VoidCallback call) => FloatingActionButton(
              child: const Icon(LineAwesomeIcons.money),
              onPressed: call,
            ),
          ),
        );
      },
    );
  }
}
