import 'package:flutter/foundation.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';

@immutable
class ParciaisItem {
  const ParciaisItem({
    @required this.date,
    @required this.hora,
  });
  final DateTime date;
  final Horas hora;
}
