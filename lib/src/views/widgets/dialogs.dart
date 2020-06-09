import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:marcaii_flutter/src/utils/vigencia.dart';
import 'package:marcaii_flutter/src/views/view_empregos/emprego_validate.dart';
import 'package:marcaii_flutter/src/views/widgets/item_picker.dart';
import 'package:marcaii_flutter/src/views/widgets/vigencia_picker.dart';
import 'package:marcaii_flutter/strings.dart';

Future<void> showAwaitingDialog({
  BuildContext context,
  GlobalKey key,
}) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return WillPopScope(
        onWillPop: () async => false,
        child: SimpleDialog(
          key: key,
          children: <Widget>[
            Column(
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 10),
                Text("Acessando servidor, aguarde...")
              ],
            )
          ],
        ),
      );
    },
  );
}

Future<bool> showConfirmationDialog({
  @required BuildContext context,
  String title = Strings.atencao,
  String message = Strings.descartarAlteracoes,
  String negativeCaption = "Não",
  String positiveCaption = "Sim",
}) async {
  return await showDialog(
    context: context,
    child: AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        FlatButton(
          child: Text(
            negativeCaption,
            style: Theme.of(context).textTheme.button.copyWith(color: Colors.black87),
          ),
          onPressed: () {
            Get.back(result: false);
          },
        ),
        FlatButton(
          child: Text(positiveCaption),
          onPressed: () {
            Get.back(result: true);
          },
        ),
      ],
    ),
  );
}

Future<Vigencia> showVigenciaPicker({
  @required BuildContext context,
  @required Vigencia vigencia,
}) async {
  return await showDialog(
    context: context,
    barrierDismissible: false,
    child: AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
      title: const Text("Nova Vigência"),
      content: VigenciaPicker(
        ano: vigencia.ano,
        mes: vigencia.mes - 1,
        onAnoSet: (int a) => vigencia.ano = a,
        onMesSet: (int m) => vigencia.mes = m,
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            "Cancelar",
            style: Theme.of(context).textTheme.button.copyWith(color: Colors.black87),
          ),
          onPressed: Get.back,
        ),
        FlatButton(
          child: const Text("Mudar"),
          onPressed: () => Get.back(result: vigencia),
        ),
      ],
    ),
  );
}

Future<int> showFechamentoPicker({
  @required BuildContext context,
  @required int fechamento,
}) async {
  return await showDialog(
    context: context,
    barrierDismissible: false,
    child: AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
      title: const Text("Fechamento do mês"),
      content: ItemPicker<int>(
        items: [for (var i = 1; i < 31; i++) i],
        initValue: fechamento,
        onCentered: (it) => fechamento = it,
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            "Cancelar",
            style: Theme.of(context).textTheme.button.copyWith(color: Colors.black87),
          ),
          onPressed: Get.back,
        ),
        FlatButton(
          child: const Text("Mudar"),
          onPressed: () => Get.back(result: fechamento + 1),
        ),
      ],
    ),
  );
}

Future<int> showIntegerPickerDialog({
  @required BuildContext context,
  @required int initValue,
  @required String label,
  @required String title,
  @required String confirmButton,
  String cancelButton = Strings.cancelar,
}) async {
  final _formKey = GlobalKey<FormState>();

  return await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      title: Text(title),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
      content: Container(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: TextFormField(
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3),
            ],
            decoration: InputDecoration(
              hintText: "9999",
              labelText: label,
            ),
            keyboardType: TextInputType.number,
            initialValue: initValue.toString(),
            onSaved: (s) {
              initValue = int.tryParse(s) ?? 0;
            },
            validator: (s) {
              return EmpregoValidate.validatePorc(s, 50);
            },
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            cancelButton,
            style: Theme.of(context).textTheme.button.copyWith(color: Colors.black87),
          ),
          onPressed: Get.back,
        ),
        FlatButton(
          child: const Text(Strings.salvar),
          onPressed: () {
            final state = _formKey.currentState;
            if (state.validate()) {
              state.save();
              Get.back(result: initValue);
            }
          },
        ),
      ],
    ),
  );
}
