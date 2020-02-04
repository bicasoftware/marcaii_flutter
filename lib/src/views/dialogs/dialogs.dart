import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/views/dialogs/awainting_dialog.dart';

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
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 10),
                const Text("Acessando servidor, aguarde...")
              ],
            )
          ],
        ),
      );
    },
  );
}

