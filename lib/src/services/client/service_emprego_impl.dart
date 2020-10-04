import 'package:marcaii_flutter/src/database/models/empregos.dart';

abstract class ServiceEmpregoImpl {
  Future<List<Empregos>> fetchEmpregos();
}