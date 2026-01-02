import 'package:boby_ai_case/core/extensions/theme/build_context_color_ext.dart';
import 'package:boby_ai_case/core/extensions/theme/build_context_text_style_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaywallRenewalInfo extends StatelessWidget {
  const PaywallRenewalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.check_circle_rounded, color: context.green, size: 16.w),
        SizedBox(width: 8.w),
        Text(
          'Auto Renewable, Cancel Anytime',
          style: context.fs12W400.copyWith(color: context.gray),
        ),
      ],
    );
  }
}
