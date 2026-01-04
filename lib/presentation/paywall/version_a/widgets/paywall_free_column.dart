part of '../paywall_page_version_a.dart';

class PaywallFreeColumn extends StatelessWidget {
  const PaywallFreeColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 9.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 1.h),
              Text(context.tr.paywall.free, style: context.textStyles.fs16W600),
              SizedBox(height: 1.h),
            ],
          ),
          SizedBox(height: 12.h),
          ...List.generate(PaywallFeatures.all.length, (index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PaywallFeatureStatusCell(
                  isAvailable: PaywallFeatures.all[index].freeAccess,
                ),
                if (index != PaywallFeatures.all.length - 1)
                  SizedBox(height: 16.h),
              ],
            );
          }),
        ],
      ),
    );
  }
}
