import 'package:boby_ai_case/core/extensions/theme/build_context_color_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaywallRadioButton extends StatelessWidget {
  const PaywallRadioButton({super.key, required this.isSelected});
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24.w,
      height: 24.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? context.redLight : Colors.transparent,
        border: isSelected
            ? null
            : Border.all(color: context.white, width: 1.5),
      ),
      child: isSelected
          ? Icon(Icons.check, color: context.white, size: 16.sp)
          : null,
    );
  }
}
