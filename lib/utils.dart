import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

setDateTimeFull(String date, int utc) => DateFormat("dd.MM.yyyy в HH:mm")
    .format(DateTime.parse(date).add(Duration(hours: utc)));

setDateTimeYear(String date) => DateFormat("yyyy").format(DateTime.parse(date));

setDateTime(String date) =>
    DateFormat("dd.MM.yyyy").format(DateTime.parse(date));

launchURL(String url) async {
  if (await canLaunch(url))
    await launch(url);
  else
    throw 'Could not launch $url';
}

void showLoginError(
  BuildContext context, {
  required String error,
  Color color = const Color(0xFFD32F2FFF),
  int duration = 1500,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      duration: Duration(milliseconds: duration),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      content: Text(
        error,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
