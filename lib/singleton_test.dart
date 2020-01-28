class Obsidia {
  factory Obsidia() {
    return _instance ??= Obsidia._internal();
  }

  Obsidia._internal();

  static Obsidia _instance;
}
