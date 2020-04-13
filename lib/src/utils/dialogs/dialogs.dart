import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/utils/vigencia.dart';
import 'package:marcaii_flutter/src/utils/vigencia_picker.dart';
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
            Navigator.of(context).pop(false);
          },
        ),
        FlatButton(
          child: Text(positiveCaption),
          onPressed: () {
            Navigator.of(context).pop(true);
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
        onAnoSet: (a) {
          vigencia.ano = a;
        },
        onMesSet: (m) {
          vigencia.mes = m;
        },
      ),
      actions: <Widget>[
        FlatButton(
          child: const Text("Cancelar"),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: const Text("Mudar"),
          onPressed: () => Navigator.of(context).pop(vigencia),
        ),
      ],
    ),
  );
}
