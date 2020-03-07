import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/utils/dialogs/dialogs.dart';
import 'package:marcaii_flutter/strings.dart';

mixin WillPopForm {
  Future<bool> willPop({
    @required BuildContext context,
    @required FormState formState,
    @required bool isCreating,
    @required bool hasChanged,
  }) async {
    if (isCreating) {
      return true;
    } else if (formState.validate()) {
      formState.save();
      if (hasChanged) {
        final r = await showCanCloseDialog(
          context: context,
          title: Strings.atencao,
          message: Strings.descartarAlteracoes,
          positiveCaption: Strings.descartar,
        );

        return r ?? true;
      } else {
        return true;
      }
    }

    return false;
  }

  void doSave({
    @required BuildContext context,
    @required FormState formState,
    @required dynamic resultData,
  }) {
    if (formState.validate()) {
      formState.save();
      Navigator.of(context).pop(resultData);
    }
  }
}
