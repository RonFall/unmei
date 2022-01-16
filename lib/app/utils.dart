import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

String setDateTimeFull(String date, int utc) {
  return DateFormat("dd.MM.yyyy в HH:mm").format(
    DateTime.parse(date).add(Duration(hours: utc)),
  );
}

String setDateTimeYear(String date) {
  return DateFormat("yyyy").format(DateTime.parse(date));
}

String setDateTime(String date) {
  return DateFormat("dd.MM.yyyy").format(DateTime.parse(date));
}

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
