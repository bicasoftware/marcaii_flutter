import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_utils/async_widgets/async_widget.dart';
import 'package:flutter_utils/config_tiles/config_tiles.dart';
import 'package:flutter_utils/currency_input_formatter.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_emprego.dart';
import 'package:marcaii_flutter/src/utils/double_utils.dart';
import 'package:marcaii_flutter/src/views/view_empregos/emprego_validate.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:provider/provider.dart';

class ViewEmpregoSalarioTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocEmprego>(context);
    return StreamObserver<double>(
      stream: b.initSalario,
      onSuccess: (_, double salario) {
        return TextTile(
          inputFormatters: [
            WhitelistingTextInputFormatter.digitsOnly,
            CurrencyInputFormatter(maxDigits: 8),
          ],
          initialValue: doubleToCurrency(salario),
          trailingWidth: 110,
          icon: const Icon(Icons.monetization_on, color: Colors.indigo),
          label: Strings.salario,
          hint: "R\$ 1000,00",
          onChanged: (s) => b.setSalarioInit(currencyStringToDouble(s)),
          validator: EmpregoValidate.validateSalario,
          inputType: const TextInputType.numberWithOptions(
            decimal: true,
            signed: false,
          ),
        );
      },
    );
  }
}
