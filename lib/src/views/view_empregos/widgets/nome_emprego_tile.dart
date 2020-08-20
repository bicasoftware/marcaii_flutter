import 'package:flutter/material.dart';
import 'package:flutter_utils/async_widgets/stream_observer.dart';
import 'package:flutter_utils/config_tiles/config_tiles.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_emprego.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:provider/provider.dart';

class NomeEmpregoTile extends StatelessWidget {
  const NomeEmpregoTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocEmprego>(context);
    return StreamObserver<String>(
      stream: b.nome,
      onSuccess: (_, nome) {
        return ComposedTextTile(
          maxLength: 32,
          icon: const Icon(
            LineAwesomeIcons.briefcase,
            color: Colors.lightBlue,
          ),
          hint: "Emprego",
          label: Strings.descricao,
          initialValue: nome,
          onChanged: b.setNome,
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
