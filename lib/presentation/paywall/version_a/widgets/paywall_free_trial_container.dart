part of '../paywall_page_version_a.dart';

class PaywallFreeTrialContainer extends StatelessWidget {
  const PaywallFreeTrialContainer({super.key});

  Color _getBackgroundColor(BuildContext context, bool isHighlight) {
    if (isHighlight) return context.colors.blue.withValues(alpha: 0.3);
    return context.colors.transparent;
  }

  Color _getBorderColor(BuildContext context, bool isHighlight) {
    if (isHighlight) return context.colors.blue;
    return context.colors.transparent;
  }

  BorderRadiusGeometry? _getBorderRadius(
    BuildContext context,
    bool isHighlight,
  ) {
    if (isHighlight) return null;
    return context.radius.radius12;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final paywallStore = context.read<PaywallStore>();
        final isHighlight = paywallStore.highlightFreeTrialSwitch;
        final isFreeTrial = paywallStore.isFreeTrial;
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          decoration: BoxDecoration(
            borderRadius: context.radius.radius12,
            border: Border.all(color: context.colors.redLight),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  context.tr.paywall.enableFreeTrial,
                  style: context.textStyles.fs16W600,
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: _getBackgroundColor(context, isHighlight),
                  borderRadius: _getBorderRadius(context, isHighlight),
                  border: Border.all(
                    color: _getBorderColor(context, isHighlight),
                  ),
                ),
                child: CupertinoSwitch(
                  value: isFreeTrial,
                  onChanged: (value) => paywallStore.toggleFreeTrial(value),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
