import 'package:marcaii_flutter/src/database/models/diferenciadas.dart';

extension DiferenciadasHelper on Diferenciadas {
   Diferenciadas forFirstSync(int emprego_id) {
    return Diferenciadas(
      id: null,
      emprego_id: emprego_id,
      porc: porc,
      weekday: weekday,
      vigencia: vigencia,
      ativo: ativo,
    );
  }
}