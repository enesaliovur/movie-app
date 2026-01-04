part of '../paywall_page_version_a.dart';

class PaywallFeatureNamesColumn extends StatelessWidget {
  const PaywallFeatureNamesColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 9.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Opacity(opacity: 0, child: ProHeader()),
          SizedBox(height: 12.h),
          ...List.generate(PaywallFeatures.all.length, (index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _PaywallFeatureNameCell(name: PaywallFeatures.all[index].name),
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

class _PaywallFeatureNameCell extends StatelessWidget {
  const _PaywallFeatureNameCell({required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.w,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(name, style: context.textStyles.fs14W600),
      ),
    );
  }
}
