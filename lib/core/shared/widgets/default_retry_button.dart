import 'package:boby_ai_case/core/extensions/theme/build_context_color_ext.dart';
import 'package:boby_ai_case/core/extensions/theme/build_context_radius_ext.dart';
import 'package:boby_ai_case/core/shared/widgets/scaling_container.dart';
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
    return ScalingContainer(
      onTap: onTap,
      child: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: btnColor ?? context.redDark,
          border: Border.all(color: btnColor ?? context.redLight),
          borderRadius: context.radius100,
        ),
        child: Icon(
          Icons.refresh,
          color: iconColor ?? context.white,
          size: 20.w,
        ),
      ),
    );
  }
}
