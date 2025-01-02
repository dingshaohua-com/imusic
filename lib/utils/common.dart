String printDuration(Duration duration) {
  String negativeSign = duration.isNegative ? '-' : '';
  String twoDigits(int n) => n.toString().padLeft(2, "0");

  // 计算小时、分钟和秒
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());

  // 判断是否显示小时部分
  if (duration.inHours == 0) {
    return "$negativeSign$twoDigitMinutes:$twoDigitSeconds";
  } else {
    return "$negativeSign${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}