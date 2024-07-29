extension TimerFormatter on int {
  String get format {
    final secondsElapsed = this;

    final hour = secondsElapsed ~/ 3600;
    final minute = (secondsElapsed - (hour * 3600)) ~/ 60;
    final seconds = secondsElapsed - (hour * 3600) - (minute * 60);

    final hourString = hour.toString().padLeft(2, '0');
    final minuteString = minute.toString().padLeft(2, '0');
    final secondsString = seconds.toString().padLeft(2, '0');

    return '$hourString:$minuteString:$secondsString';
  }
}
