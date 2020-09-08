import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_utils/config_tiles/composed_text_tile.dart';
import 'package:flutter_utils/flutter_utils.dart';

import 'package:marcaii_flutter/src/utils/double_utils.dart';
import 'package:marcaii_flutter/src/views/view_empregos/emprego_validate.dart';

class CurrencyTile extends StatelessWidget {
  const CurrencyTile({
    @required this.salario,
    @required this.label,
    @required this.onChanged,
    Key key,
  }) : super(key: key);
  final double salario;
  final String label;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return ComposedTextTile(      
      inputFormatters: [
        WhitelistingTextInputFormatter.digitsOnly,
        CurrencyInputFormatter(maxDigits: 8),
      ],
      initialValue: doubleToCurrency(salario),
      maxLength: null,
      // trailingWidth: 110,
      icon: const Icon(Icons.monetization_on, color: Colors.indigo),
      label: label,
      hint: "R\$ 1000,00",
      onChanged: onChanged,
      validator: EmpregoValidate.validateSalario,
      inputType: const TextInputType.numberWithOptions(
        decimal: true,
        signed: false,
      ),
    );
  }
}

