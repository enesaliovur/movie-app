import 'dart:io';
import 'package:boby_ai_case/core/extensions/theme/build_context_color_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultProgressIndicator extends StatelessWidget {
  const DefaultProgressIndicator({super.key, this.size, this.color});
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? 28.w,
      height: size ?? 28.h,
      child: Platform.isIOS
          ? CupertinoActivityIndicator(color: color ?? context.redLight)
          : CircularProgressIndicator(color: color ?? context.redLight),
    );
  }
}
