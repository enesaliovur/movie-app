import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension BuildContextRadiusExt on BuildContext {
  AppRadius get radius => const AppRadius();
}

class AppRadius {
  const AppRadius();
  BorderRadius get radius8 => BorderRadius.circular(8.r);
  BorderRadius get radius10 => BorderRadius.circular(10.r);
  BorderRadius get radius12 => BorderRadius.circular(12.r);
  BorderRadius get radius16 => BorderRadius.circular(16.r);
  BorderRadius get radius100 => BorderRadius.circular(100.r);
}
