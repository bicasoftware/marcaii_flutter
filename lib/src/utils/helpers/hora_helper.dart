import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';

extension HoraHelper on Horas {
  Color getColor() {
    switch (this.tipo) {
      case 0:
        return Colors.lightGreen;
        break;
      case 1:
        return Colors.amber;
        break;
      case 2:
        return Colors.red;
        break;
      default:
        return Colors.lightGreen;
        break;
    }
  }
}
