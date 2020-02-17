import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/strings.dart';

class ViewHomeDrawer extends StatelessWidget {
  const ViewHomeDrawer({
    @required this.onAddTapped,
    @required this.onChanged,
    @required this.onEmpregoTap,
    Key key,
  }) : super(key: key);

  final VoidCallback onAddTapped;
  final void Function(int pos) onChanged;
  final void Function(Empregos emprego) onEmpregoTap;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            DrawerHeader(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Image.asset(
                      "assets/images/logo.png",
                      height: 80,
                      fit: BoxFit.fitHeight,
                      scale: 1.1,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          Strings.appName,
                          style: Theme.of(context).textTheme.body2.copyWith(color: Colors.white),
                        ),
                        const Spacer(),
                        Theme(
                          data: Theme.of(context).copyWith(canvasColor: Colors.deepOrange),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              onChanged: onChanged,
                              value: 0,
                              items: [
                                DropdownMenuItem(
                                  value: 0,
                                  child: Text(
                                    "Usuário",
                                    style: Theme.of(context)
                                        .textTheme
                                        .button
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 1,
                                  child: Text(
                                    "Sair",
                                    style: Theme.of(context)
                                        .textTheme
                                        .button
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 2,
                                  child: Text(
                                    "Alterar Senha",
                                    style: Theme.of(context)
                                        .textTheme
                                        .button
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.deepOrange[900],
                    Colors.red,
                    Colors.deepOrange,
                    Colors.orange,
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text(Strings.adicionar),
              onTap: onAddTapped,
            ),
            const Divider(),
            Expanded(
              child: ListView(
                children: <Widget>[
                  //TODO - carregar lista de empregos vindos do BLOC
                  for (int i = 0; i < 3; i++)
                    ListTile(
                      leading: Icon(Icons.work),
                      title: Text("Emprego ${i + 1}"),
                      subtitle: const Text("200 | 18:00"),
                      //TODO - passar emprego no lugar do null
                      onTap: () => onEmpregoTap(null),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
