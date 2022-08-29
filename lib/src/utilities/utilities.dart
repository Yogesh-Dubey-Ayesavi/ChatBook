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

 const Uuid uuid =  Uuid();

 RegExp exp = RegExp(r'(?:(?:https?|ftp):)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
   