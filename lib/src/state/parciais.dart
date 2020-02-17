import 'package:flutter/foundation.dart';
import 'package:marcaii_flutter/src/state/parciais_item.dart';

class Parciais {
  Parciais({
    @required this.vigencia,
    @required this.items,
  });
  final String vigencia;
  final List<ParciaisItem> items;
}
