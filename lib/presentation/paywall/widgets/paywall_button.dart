import 'package:boby_ai_case/core/extensions/screen_extension.dart';
import 'package:boby_ai_case/core/extensions/theme/build_context_color_ext.dart';
import 'package:boby_ai_case/core/extensions/theme/build_context_text_style_ext.dart';
import 'package:boby_ai_case/core/shared/widgets/scaling_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaywallButton extends StatelessWidget {
  const PaywallButton({super.key, required this.title, this.icon});
  final String title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ScalingContainer(
      onTap: () {},
      child: Container(
        width: context.screenWidth,
        height: 56.h,
        decoration: BoxDecoration(
          color: context.redLight,
          borderRadius: BorderRadius.circular(12.w),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(title, style: context.fs16W600.copyWith(color: context.white)),
            if (icon != null)
              Positioned(
                right: 16.w,
                child: Icon(icon, size: 24.sp, color: context.white),
              ),
          ],
        ),
      ),
    );
  }
}
