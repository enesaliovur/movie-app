import 'package:boby_ai_case/core/extensions/theme/build_context_color_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension BuildContextTextStyleExt on BuildContext {
  AppTextStyles get textStyles => AppTextStyles(this);
}

class AppTextStyles {
  final BuildContext _context;
  AppTextStyles(this._context);

  TextStyle get fs8W400 {
    return TextStyle(
      fontSize: 8.sp,
      fontWeight: FontWeight.w400,
      color: _context.colors.white,
      letterSpacing: 0,
      height: 1,
    );
  }

  TextStyle get fs12W400 {
    return TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: _context.colors.white,
      letterSpacing: 0,
      height: 1,
    );
  }

  TextStyle get fs12W500 {
    return TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      color: _context.colors.white,
      letterSpacing: 0,
      height: 1,
    );
  }

  TextStyle get fs14W400 {
    return TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: _context.colors.white,
      letterSpacing: 0,
      height: 1,
    );
  }

  TextStyle get fs14W600 {
    return TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      color: _context.colors.white,
      letterSpacing: 0,
      height: 1,
    );
  }

  TextStyle get fs16W400 {
    return TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: _context.colors.white,
      letterSpacing: 0,
      height: 1,
    );
  }

  TextStyle get fs16W600 {
    return TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: _context.colors.white,
      letterSpacing: 0,
      height: 1,
    );
  }

  TextStyle get fs17W400 {
    return TextStyle(
      fontSize: 17.sp,
      fontWeight: FontWeight.w400,
      color: _context.colors.white,
      letterSpacing: 0,
      height: 1,
    );
  }

  TextStyle get fs18W600 {
    return TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: _context.colors.white,
      letterSpacing: 0,
      height: 1,
    );
  }

  TextStyle get fs20W400 {
    return TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w400,
      color: _context.colors.white,
      letterSpacing: 0,
      height: 1,
    );
  }

  TextStyle get fs20W500 {
    return TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w500,
      color: _context.colors.white,
      letterSpacing: 0,
      height: 1,
    );
  }

  TextStyle get fs20W600 {
    return TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w600,
      color: _context.colors.white,
      letterSpacing: 0,
      height: 1,
    );
  }

  TextStyle get fs24W700 {
    return TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.w700,
      color: _context.colors.white,
      letterSpacing: 0,
      height: 1,
    );
  }

  TextStyle get fs32W800 {
    return TextStyle(
      fontSize: 32.sp,
      fontWeight: FontWeight.w800,
      color: _context.colors.white,
      letterSpacing: 0,
      height: 1,
    );
  }
}
