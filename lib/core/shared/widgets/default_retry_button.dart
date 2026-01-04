import 'package:boby_ai_case/core/extensions/theme/build_context_color_ext.dart';
import 'package:boby_ai_case/core/extensions/theme/build_context_radius_ext.dart';
import 'package:boby_ai_case/core/shared/widgets/default_animated_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultRetryButton extends StatelessWidget {
  const DefaultRetryButton({
    super.key,
    required this.onTap,
    this.btnColor,
    this.iconColor,
  });

  final VoidCallback onTap;
  final Color? btnColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return DefaultAnimatedContainer(
      onTap: onTap,
      child: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: btnColor ?? context.colors.redDark,
          border: Border.all(color: btnColor ?? context.colors.redLight),
          borderRadius: context.radius.radius100,
        ),
        child: Icon(
          Icons.refresh,
          color: iconColor ?? context.colors.white,
          size: 20.w,
        ),
      ),
    );
  }
}
