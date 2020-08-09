import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_utils/flutter_utils.dart';
import 'package:marcaii_flutter/src/utils/double_utils.dart';
import 'package:marcaii_flutter/src/utils/vigencia.dart';
import 'package:marcaii_flutter/src/views/widgets/appbar_save_button.dart';
import 'package:marcaii_flutter/src/views/widgets/vigencia_picker.dart';
import 'package:marcaii_flutter/src/views/view_empregos/emprego_validate.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:flutter_utils/currency_input_formatter.dart';

class ViewInsertSalario extends StatefulWidget {
  const ViewInsertSalario({
    @required this.isCreating,
    this.salario,
    this.vigencia,
    Key key,
  }) : super(key: key);

  final double salario;
  final String vigencia;
  final bool isCreating;

  @override
  _ViewInsertSalarioState createState() => _ViewInsertSalarioState();
}

class _ViewInsertSalarioState extends State<ViewInsertSalario> with WillPopForm {
  final anos = List.generate(30, (i) => 2010 + i);
  final meses = List.generate(12, (i) => i);

  double _salario;
  Vigencia _vigencia;

  @override
  void initState() {
    if (widget.vigencia == null) {
      final dt = DateTime.now();
      _vigencia = Vigencia(ano: dt.year, mes: dt.month);
    } else {
      _vigencia = Vigencia.fromString(widget.vigencia);
    }
    _salario = widget.salario ?? 998.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async => willPop(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(Strings.salario),
          actions: <Widget>[
            AppbarSaveButton(onPressed: () {
              saveForm(
                resultData: {
                  "vigencia": _vigencia.vigencia,
                  "valor": _salario,
                },
              );
            }),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Form(
                key: formKey,
                child: TextFormField(
                  initialValue: doubleToCurrency(_salario),
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                    CurrencyInputFormatter(maxDigits: 8),
                  ],
                  decoration: InputDecoration(
                    hintText: doubleToCurrency(998.0),
                    labelText: Strings.salario,
                  ),
                  validator: EmpregoValidate.validateSalario,
                  onChanged: (s) => _salario = currencyStringToDouble(s),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: false,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                Strings.vigencia,
                textAlign: TextAlign.start,
                style: theme.textTheme.caption.copyWith(color: theme.accentColor),
              ),
              VigenciaPicker(
                backgroundColor: Theme.of(context).canvasColor,
                ano: _vigencia.ano,
                mes: _vigencia.mes,
                onMesSet: (m) => _vigencia.mes = m,
                onAnoSet: (a) => _vigencia.ano = a,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get checkForChanges {
    return !(_vigencia.vigencia == widget.vigencia && _salario == widget.salario);
  }

  @override
  bool get isNewRecord => widget.isCreating;
}
