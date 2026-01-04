part of '../paywall_page_version_a.dart';

class PaywallFeaturesTable extends StatelessWidget {
  const PaywallFeaturesTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(child: PaywallFeatureNamesColumn()),
        const PaywallFreeColumn(),
        SizedBox(width: 12.w),
        const PaywallProColumn(),
      ],
    );
  }
}
