import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_emprego.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:provider/provider.dart';
import 'package:marcaii_flutter/src/views/shared/config_tiles/composed_text_tile.dart';

class NomeEmpregoTile extends StatelessWidget {
  const NomeEmpregoTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocEmprego>(context);
    return StreamObserver<String>(
      stream: b.nome,
      onSuccess: (_, nome) {
        return ComposedTextTile(
          icon: Icon(
            Icons.work,
            color: Colors.lightBlue,
          ),
          hint: "Emprego",
          label: Strings.descricao,
          initialValue: nome,
          onSaved: b.setNome,
          validator: (String s) {
            if (s.isEmpty) {
              return "Descrição obrigatória";
            } else {
              return null;
            }
          },
        );
      },
    );
  }
}