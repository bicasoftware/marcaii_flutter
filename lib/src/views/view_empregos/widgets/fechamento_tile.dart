import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lib_observer/stream_observer.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_emprego.dart';
import 'package:marcaii_flutter/src/views/shared/config_tiles/text_tile.dart';
import 'package:marcaii_flutter/src/views/view_empregos/emprego_validate.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:provider/provider.dart';

class FechamentoTile extends StatelessWidget {

  const FechamentoTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocEmprego>(context);

    return StreamObserver<int>(
      stream: b.fechamento,
      onSuccess: (BuildContext context, int dia) {
        return TextTile(
          inputFormatters: [
            WhitelistingTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(2),
          ],
          trailingWidth: 32,
          icon: Icon(
            Icons.date_range,
            color: Colors.pink,
          ),
          label: Strings.fechamento,
          initialValue: dia.toString(),
          hint: "25",
          inputType: TextInputType.number,
          validator: EmpregoValidate.validateFechamento,
          onSaved: (String s) => b.setFechamento(int.tryParse(s)),
        );
      },
    );
  }
}
