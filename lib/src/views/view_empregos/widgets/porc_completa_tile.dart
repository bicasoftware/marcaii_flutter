import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_emprego.dart';
import 'package:marcaii_flutter/src/views/view_empregos/emprego_validate.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:provider/provider.dart';
import 'package:marcaii_flutter/src/views/shared/config_tiles/text_tile.dart';

class PorcCompletaTile extends StatelessWidget {
  const PorcCompletaTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocEmprego>(context);

    return StreamObserver<int>(
      stream: b.porcCompleta,
      onSuccess: (_, porc) {
        return TextTile(
          inputFormatters: [
            WhitelistingTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(3),
          ],
          trailingWidth: 32,
          icon: Icon(
            Icons.info,
            color: Consts.horaColor[1],
          ),
          label: Strings.porcCompleta,
          initialValue: porc.toString(),
          hint: "100",
          inputType: TextInputType.number,
          validator: (String s) => EmpregoValidate.validatePorc(s, 50),
          onSaved: (String s) => b.setPorcCompleta(int.tryParse(s)),
        );
      },
    );
  }
}
