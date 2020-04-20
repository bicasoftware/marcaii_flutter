import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:marcaii_flutter/src/utils/token_manager.dart';
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
            subtitle: FutureObserver<String>(
              future: Vault().getEmail(),
              onSuccess: (_, String email) => Text(email),
            ),
          ),
          const Divider(),
          ListSectionDecorator(label: Strings.empregos),
          ViewListEmpregos(),
          const Spacer(),
          DrawerContainer(
            child: ListTile(
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
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}
