class MinutesHelper {
  static String minutesToHoras(int time) {
    final horas = (time / 60).floor();
    final minutes = time % 60;
    return "${_pad(horas)}:${_pad(minutes)}";
  }

  static String _pad(int val) => val.toString().padLeft(2, '0');
}
