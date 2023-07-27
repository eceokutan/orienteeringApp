class Utilities {
  static String milisecondstotime(int timeinms) {
    double sec = timeinms / 1000;
    double min = sec / 60;
    int minutes = min.toInt();
    int seconds = ((min - minutes) * 100).toInt();
    return "$minutes minutes $seconds seconds";
  }
}
