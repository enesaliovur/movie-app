part of '../paywall_page_version_a.dart';

class PaywallFeatureStatusCell extends StatelessWidget {
  const PaywallFeatureStatusCell({
    super.key,
    required this.isAvailable,
    this.isAnimated = false,
  });

  final bool isAvailable;
  final bool isAnimated;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.h,
      width: 20.w,
      child: Center(
        child: isAnimated
            ? AnimatedStatusIcon(isAvailable: isAvailable)
            : StatusIcon(isAvailable: isAvailable),
      ),
    );
  }
}

class StatusIcon extends StatelessWidget {
  const StatusIcon({super.key, required this.isAvailable});
  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    return Icon(
      isAvailable ? Icons.check_circle_rounded : Icons.cancel_rounded,
      color: isAvailable ? context.colors.green : context.colors.white,
      size: 20.sp,
    );
  }
}

class AnimatedStatusIcon extends StatelessWidget {
  const AnimatedStatusIcon({super.key, required this.isAvailable});
  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    return Icon(
      isAvailable ? Icons.check_circle_rounded : Icons.cancel_rounded,
      key: ValueKey(isAvailable),
      color: isAvailable ? context.colors.green : context.colors.white,
      size: 20.sp,
    );
  }
}
