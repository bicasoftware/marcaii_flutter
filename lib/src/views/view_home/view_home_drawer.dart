import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:marcaii_flutter/src/utils/vault.dart';
import 'package:marcaii_flutter/src/views/view_empregos/widgets/list_section_decorator.dart';
import 'package:marcaii_flutter/src/views/view_list_empregos/view_list_empregos.dart';
import 'package:marcaii_flutter/strings.dart';

class ViewHomeDrawer extends StatelessWidget {
  const ViewHomeDrawer({
    @required this.onNewEmprego,
    Key key,
  }) : super(key: key);

  final VoidCallback onNewEmprego;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          const SizedBox(height: 32),
          ListTile(
            leading: Image.asset("assets/images/app_icon.png"),
            title: const Text(Strings.appName),
            subtitle: const Text(Strings.appDescricao),
          ),
          const Divider(),
          const ListSectionDecorator(
            label: Strings.empregos,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          ),
          ViewListEmpregos(),
          DrawerContainer(
            child: ListTile(
              dense: true,
              title: const Text("Adicionar Emprego"),
              trailing: Icon(Icons.add),
              onTap: onNewEmprego,
            ),
          ),
          const Divider(),
          ListTile(leading: Icon(Icons.lightbulb_outline)),
        ],
      ),
    );
  }
}

class DrawerContainer extends StatelessWidget {
  const DrawerContainer({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.deepPurple[50],
        borderRadius: BorderRadius.circular(4),
      ),
      child: child,
    );
  }
}
