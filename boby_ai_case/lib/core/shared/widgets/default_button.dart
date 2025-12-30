import 'package:boby_ai_case/core/extensions/theme/build_context_color_ext.dart';
import 'package:boby_ai_case/core/extensions/theme/build_context_radius_ext.dart';
import 'package:boby_ai_case/core/shared/widgets/scaling_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultButton extends StatefulWidget {
  const DefaultButton({
    super.key,
    this.color,
    this.border,
    this.vertical = 12,
    this.horizontal = 16,
    this.width,
    this.height,
    required this.child,
    required this.onTap,
  });
  final Widget child;
  final double? height;
  final double? width;
  final Color? color;
  final BoxBorder? border;
  final void Function() onTap;
  final double vertical;
  final double horizontal;

  @override
  State<DefaultButton> createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton> {
  @override
  Widget build(BuildContext context) {
    return ScalingContainer(
      shrinkWrap: true,
      onTap: () {
        widget.onTap();
      },
      child: Container(
        height: widget.height ?? 56.h,
        width: widget.width ?? 375.w,
        decoration: BoxDecoration(
          border: widget.border,
          color: widget.color ?? context.redLight,
          borderRadius: context.radius16,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: widget.horizontal,
            vertical: widget.vertical,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
