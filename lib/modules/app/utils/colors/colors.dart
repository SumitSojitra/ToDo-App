import 'dart:ui';
import 'package:flutter/material.dart';

class AppColor {
  static Color kWhite = Color(0xfff5f5f3);
  static LinearGradient itroGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      const Color(0xFF110C1D).withOpacity(0.0),
      const Color(0xFF110C1D),
    ],
  );
}
