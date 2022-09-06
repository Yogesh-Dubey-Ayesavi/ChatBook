part of '../../chatbook.dart';

bool sameDay(int firstStamp, int? secondStamp) {
  if (DateFormat('dd MMM yyyy')
          .format(DateTime.fromMicrosecondsSinceEpoch(firstStamp)) ==
      DateFormat('dd MMM yyyy')
          .format(DateTime.fromMicrosecondsSinceEpoch(secondStamp!))) {
    return true;
  } else {
    return false;
  }
}

Duration intToDurationFormatter(double duration) {
  double h, m, s;
  h = duration ~/ 3600 as double;
  m = ((duration - h * 3600)) ~/ 60 as double;
  s = duration - (h * 3600) - (m * 60);
  return Duration(seconds: s as int, minutes: m as int, hours: h as int);
}

const Uuid uuid = Uuid();

RegExp exp = RegExp(r'(?:(?:https?|ftp):)?[\w/\-?=%.]+\.[\w/\-?=%.]+');

String getFileSize(int bytesLength, int decimals) {
  // var file = File(filepath);
  int bytes = bytesLength;
  if (bytes <= 0) return "0 B";
  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  var i = (log(bytes) / log(1024)).floor();
  return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
}
