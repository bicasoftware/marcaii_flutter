import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marcaii_flutter/src/utils/currency_formatter.dart';
import 'package:marcaii_flutter/src/utils/double_utils.dart';
import 'package:marcaii_flutter/src/utils/form_view.dart';
import 'package:marcaii_flutter/src/utils/vigencia.dart';
import 'package:marcaii_flutter/src/views/shared/appbar_save_button.dart';
import 'package:marcaii_flutter/src/views/view_empregos/emprego_validate.dart';
import 'package:marcaii_flutter/strings.dart';

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
  final _formKey = GlobalKey<FormState>();

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
      onWillPop: () => willPop(
        context: context,
        formState: _formKey.currentState,
        hasChanged: !(_vigencia.vigencia == widget.vigencia && _salario == widget.salario),
        isCreating: widget.isCreating,
      ),
      // onWillPop: _canPopup,
      child: Scaffold(
        appBar: AppBar(
          title: Text(Strings.salario),
          actions: <Widget>[
            AppbarSaveButton(
              onPressed: () => doSave(
                context: context,
                formState: _formKey.currentState,
                resultData: {
                  "vigencia": _vigencia.vigencia,
                  "valor": _salario,
                },
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                Strings.vigencia,
                textAlign: TextAlign.start,
                style: theme.textTheme.caption.copyWith(color: theme.accentColor),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    flex: 6,
                    child: DropdownButton<int>(
                      value: _vigencia.mes,
                      onChanged: (i) => setState(() => _vigencia.mes = i),
                      isExpanded: true,
                      items: <DropdownMenuItem<int>>[
                        for (final m in meses)
                          DropdownMenuItem<int>(
                            value: m,
                            child: Text(Consts.meses[m]),
                          )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 4,
                    child: DropdownButton<int>(
                      isExpanded: true,
                      value: _vigencia.ano,
                      onChanged: (i) => setState(() => _vigencia.ano = i),
                      items: <DropdownMenuItem<int>>[
                        for (final a in anos)
                          DropdownMenuItem<int>(
                            value: a,
                            child: Text(a.toString()),
                          )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Form(
                key: _formKey,
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
            ],
          ),
        ),
      ),
    );
  }
}
