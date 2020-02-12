import 'package:flutter/material.dart';

class AwaitingDialog {
  AwaitingDialog({
    @required this.context,
    @required this.key,
    @required this.children,
  });

  final BuildContext context;
  final GlobalKey key;
  final Widget children;

  Future<void> show() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return WillPopScope(
          onWillPop: () async => false,
          child: SimpleDialog(
            key: key,
            backgroundColor: Colors.black54,
            children: <Widget>[children],
          ),
        );
      },
    );
  }
}
