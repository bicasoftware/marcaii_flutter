class Vigencia {
  Vigencia({int ano, int mes}) {
    this.ano = ano;
    this.mes = mes - 1;
  }

  Vigencia.fromString(String vigencia) {
    final vig = parseVigencia(vigencia);
    this.mes = vig[0] - 1;
    this.ano = vig[1];
  }

  int ano, mes;

  String get vigencia => formatVigencia(ano, mes);

  static String formatVigencia(int ano, int mes) {
    return "${_rightIndexMonth(mes)}/$ano";
  }

  static List<int> parseVigencia(String vigencia) {
    return vigencia.split("/").map(int.parse).toList();
  }

  static String _rightIndexMonth(int mes) {
    return (mes + 1).toString().padLeft(2, "0");
  }
}
