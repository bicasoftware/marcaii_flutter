import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:marcaii_flutter/src/views/widgets/dialogs.dart';
import 'package:marcaii_flutter/strings.dart';

mixin WillPopForm<T extends StatefulWidget> on State<T> {
  GlobalKey<FormState> _formKey;

  GlobalKey<FormState> get formKey => _formKey;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @protected
  bool get checkForChanges;

  @protected
  bool get isNewRecord;

  Future<bool> willPop() async {
    if (isNewRecord) {
      return true;
    } else if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (checkForChanges) {
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

  void saveForm({
    @required dynamic resultData,
  }) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Get.back(result: resultData);
    }
  }
}
