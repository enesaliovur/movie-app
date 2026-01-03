part of '../paywall_page_version_b.dart';

class PaywallHeader extends StatelessWidget {
  const PaywallHeader({super.key, required this.fromOnboarding});
  final bool fromOnboarding;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: IconButton(
        icon: Container(
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.white.withValues(alpha: 0.1),
          ),
          child: Icon(Icons.close, color: context.white, size: 20.sp),
        ),
        onPressed: () {
          if (fromOnboarding) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}
