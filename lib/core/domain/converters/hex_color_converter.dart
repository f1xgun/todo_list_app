import 'package:flutter/material.dart';

Color getColorFromHex(String hexColor) {
  var hex = hexColor.replaceAll('#', '');
  if (hex.length == 6) {
    hex = 'FF$hex';
  }
  return Color(int.parse(hex, radix: 16));
}
