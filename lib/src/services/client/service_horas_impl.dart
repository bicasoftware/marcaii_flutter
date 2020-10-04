import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/src/database/models/insert_result.dart';

abstract class ServiceHorasImpl {
  Future<InsertResult> post(Horas hora);
  Future<List<Horas>> fetchHora(int empregoId);
}