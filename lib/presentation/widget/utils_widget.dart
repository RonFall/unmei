import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

onBoxShim({
  double? height,
  double? width,
  EdgeInsets margin = const EdgeInsets.all(0),
  double radius = 0,
  Color bodyColor = const Color(0xFFB3B3B3),
  Color color = const Color(0xFFDBDBDB),
}) => Shimmer.fromColors(
  baseColor: bodyColor,
  highlightColor: color,
  child: Container(
    margin: margin,
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(radius),
    ),
  ),
);

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
