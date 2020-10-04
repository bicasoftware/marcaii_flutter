import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_main.dart';
import 'package:marcaii_flutter/src/views/view_calendario/models/calendario_child.dart';
import 'package:marcaii_flutter/src/utils/vigencia.dart';
import 'package:marcaii_flutter/src/views/view_calendario/calendario/calendario_header.dart';
import 'package:marcaii_flutter/src/views/view_calendario/calendario/calendario_page.dart';
import 'package:marcaii_flutter/src/views/view_calendario/calendario_navigator.dart';
import 'package:marcaii_flutter/src/views/view_calendario/view_calendario_presenter.dart';
import 'package:provider/provider.dart';

class ViewCalendario extends StatefulWidget {
  const ViewCalendario({
    @required this.empregos,
    @required this.vigencia,
    @required this.index,
    Key key,
  }) : super(key: key);

  final List<Empregos> empregos;
  final Vigencia vigencia;
  final int index;

  @override
  _ViewCalendarioState createState() => _ViewCalendarioState();
}

class _ViewCalendarioState extends State<ViewCalendario> with TickerProviderStateMixin {
  TabController controller;

  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocMain>(context, listen: false);
    final theme = Theme.of(context);
    final presenter = ViewCalendarioPresenter(context);

    controller = presenter.provideController(
      ticker: this,
      initialIndex: widget.index,
      length: widget.empregos.length,
    )..addListener(() {
        if (!controller.indexIsChanging) {
          b.setNavPosition(controller.index);
        }
      });

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        CalendarioNavigator(),
        const Divider(height: 0, indent: 16, endIndent: 16),
        if (widget.empregos.length > 1)
          TabBar(
            controller: controller,
            labelColor: theme.accentColor,
            unselectedLabelColor: theme.primaryColorLight,
            tabs: presenter.generateTabs(widget.empregos),
          ),
        CalendarioHeader(),
        const Divider(height: 0, indent: 16, endIndent: 16),
        Expanded(
          child: TabBarView(
            controller: controller,
            children: [
              for (final e in widget.empregos)
                CalendarioPage(
                  emprego: e,
                  onItemTap: (CalendarioChild child) => presenter.onItemTap(
                    child: child,
                    vigencia: widget.vigencia,
                    emprego: e,
                    onAddHora: b.addHora,
                    onRemoveHora: b.removeHora,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
