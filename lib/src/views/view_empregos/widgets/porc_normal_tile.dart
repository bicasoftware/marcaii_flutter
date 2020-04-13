import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_emprego.dart';
import 'package:marcaii_flutter/src/views/shared/config_tiles/text_tile.dart';
import 'package:marcaii_flutter/src/views/view_empregos/emprego_validate.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:provider/provider.dart';

class PorcNormalTile extends StatelessWidget {
  const PorcNormalTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocEmprego>(context);
    return StreamObserver<int>(
      stream: b.porcNormal,
      onSuccess: (_, porc) {
        return TextTile(
          inputFormatters: [
            WhitelistingTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(3),
          ],
          inputType: TextInputType.number,
          trailingWidth: 32,
          icon: Icon(
            LineAwesomeIcons.info_circle,
            color: Consts.horaColor.first,
          ),
          hint: "50",
          label: Strings.porc,
          initialValue: porc.toString(),
          onChanged: (s) => b.setPorcNormal(int.tryParse(s) ?? 0),
          validator: (s) {
            return EmpregoValidate.validatePorc(s, 50);
          },
        );
      },
    );
  }
}
