part of '../../chatbook.dart';

Future<void> _launchInBrowser(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    throw 'Could not launch $url';
  }
}

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

Duration intToDurationFormatter(int duration) {
  int h, m, s;
  h = duration ~/ 3600;
  m = ((duration - h * 3600)) ~/ 60;
  s = duration - (h * 3600) - (m * 60);
  return Duration(seconds: s, minutes: m, hours: h);
}
