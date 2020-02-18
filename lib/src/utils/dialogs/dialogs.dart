import 'package:flutter/material.dart';

/* Future<void> showAwaitingDialog({
  @required BuildContext context,
  @required GlobalKey key,
}) async {
  return AwaitingDialog(
    context: context,
    key: key,
    children: Column(
      children: const [
        CircularProgressIndicator(),
        SizedBox(height: 10),
        Text("Acessando servidor, aguarde...")
      ],
    ),
  );
} */

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

Future<bool> showCanCloseDialog({
  @required BuildContext context,
  @required String title,
  @required String message,
  String negativeCaption = "Não",
  String positiveCaption = "Sim",
}) async {
  return await showDialog(
    context: context,
    child: AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        FlatButton(
          child: Text(negativeCaption),
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
