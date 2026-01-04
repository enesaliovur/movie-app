import 'package:flutter/material.dart';

extension BuildContextColorExt on BuildContext {
  AppColors get colors => const AppColors();
}

class AppColors {
  const AppColors();
  Color get redLight => const Color(0xffCB2C2C);
  Color get redDark => const Color(0xff8C2626);
  Color get blue => const Color(0xff2C6BCB);
  Color get black => const Color(0xff0F0E0E);
  Color get green => const Color(0xff00E275);
  Color get white => const Color(0xffF3E9E9);
  Color get grayLight => const Color(0xffDED5D5);
  Color get grayDark => const Color(0xff968D8D);
  Color get yellow => const Color(0xFFFFD700);
  Color get transparent => Colors.transparent;
}
