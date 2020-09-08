import 'package:flutter/material.dart';
import 'package:marcaii_flutter/context_helper.dart';
import 'package:marcaii_flutter/src/utils/vigencia.dart';
import 'package:marcaii_flutter/src/views/widgets/item_picker.dart';
import 'package:marcaii_flutter/src/views/widgets/vigencia_picker.dart';

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
          onPressed: () => context.goBack<Object>(),
        ),
        FlatButton(
          child: const Text("Mudar"),
          onPressed: () => context.goBack<Object>(vigencia),
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
            style: context.textTheme.button.copyWith(color: Colors.black87),
          ),
          onPressed: () => context.goBack<Object>(),
        ),
        FlatButton(
          child: const Text("Mudar"),
          onPressed: () => context.goBack<int>(fechamento + 1),
        ),
      ],
    ),
  );
}
