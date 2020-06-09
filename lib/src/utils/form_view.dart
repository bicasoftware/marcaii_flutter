import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marcaii_flutter/src/views/widgets/dialogs.dart';
import 'package:marcaii_flutter/strings.dart';

mixin WillPopForm {
  static Future<bool> willPop({
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
        final r = await showConfirmationDialog(
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

  static void doSave({
    @required BuildContext context,
    @required FormState formState,
    @required dynamic resultData,
  }) {
    if (formState.validate()) {
      formState.save();
      Get.back(result: resultData);
    }
  }
}
