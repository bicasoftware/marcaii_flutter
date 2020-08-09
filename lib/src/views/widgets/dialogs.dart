import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marcaii_flutter/src/utils/double_utils.dart';
import 'package:marcaii_flutter/src/utils/vigencia.dart';
import 'package:marcaii_flutter/src/views/widgets/item_picker.dart';
import 'package:marcaii_flutter/src/views/widgets/salario_tile.dart';
import 'package:marcaii_flutter/src/views/widgets/vigencia_picker.dart';
import 'package:marcaii_flutter/strings.dart';

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

Future<double> showSalarioPicker({
  @required BuildContext context,
  @required double salario,
}) async {
  return await showDialog(
    context: context,
    barrierDismissible: false,
    child: AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
      title: const Text(Strings.salario),
      content: CurrencyTile(
        salario: salario,
        label: Strings.salario,
        onChanged: (s) => salario = currencyStringToDouble(s),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            Strings.cancelar,
            style: Theme.of(context).textTheme.button.copyWith(color: Colors.black87),
          ),
          onPressed: Get.back,
        ),
        FlatButton(
          child: const Text(Strings.salvar),
          onPressed: () => Get.back(result: salario),
        ),
      ],
    ),
  );
}
