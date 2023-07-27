import 'dart:developer';

class Utilities {
  static String milisecondstotime(int timeinms) {
    log("timeinms: $timeinms");

    int seconds = (timeinms / 1000).floor();
    int minutes = (seconds / 60).floor();
    seconds = seconds - (minutes * 60);

    return "$minutes minutes $seconds seconds";
  }
}
