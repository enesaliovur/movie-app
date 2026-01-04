import 'package:boby_ai_case/core/extensions/theme/build_context_color_ext.dart';
import 'package:boby_ai_case/core/extensions/theme/build_context_text_style_ext.dart';
import 'package:boby_ai_case/core/shared/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaywallButton extends StatelessWidget {
  const PaywallButton({super.key, required this.title, this.icon});
  final String title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return DefaultButton(
      onTap: () {},
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(title, style: context.textStyles.fs16W600.copyWith(color: context.colors.white)),
          if (icon != null)
            Positioned(
              right: 16.w,
              child: Icon(icon, size: 24.sp, color: context.colors.white),
            ),
        ],
      ),
    );
  }
}
