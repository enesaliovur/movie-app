part of '../paywall_page_version_a.dart';

class PaywallProductListTile extends StatelessWidget {
  const PaywallProductListTile({
    super.key,
    required this.product,
    required this.isSelected,
    required this.onTap,
    this.isHighlight = false,
  });
  final ProductEntity product;
  final bool isSelected;
  final bool isHighlight;
  final Function onTap;

  String _getSubtitle(BuildContext context) {
    return switch (product.tier) {
      1 => context.tr.paywall.weeklySubPriceFallback(product.weeklyPrice),
      2 => context.tr.paywall.weeklySubPriceFallback(product.weeklyPrice),
      _ => context.tr.paywall.weeklySubPriceFallback(product.weeklyPrice),
    };
  }

  String _getPriceText(BuildContext context) {
    return switch (product.tier) {
      1 => context.tr.paywall.monthlyPrice(product.price),
      2 => context.tr.paywall.yearlyPrice(product.price),
      _ => context.tr.paywall.weeklyPrice(product.price),
    };
  }

  Color _getBorderColor(BuildContext context) {
    if (isSelected) return context.colors.redLight;
    if (isHighlight) return context.colors.blue;
    return context.colors.white;
  }

  Color _getBackgroundColor(BuildContext context) {
    if (isHighlight) return context.colors.blue.withValues(alpha: 0.2);
    return context.colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: context.screenWidth,
        decoration: BoxDecoration(
          color: _getBackgroundColor(context),
          borderRadius: context.radius.radius12,
          border: Border.all(color: _getBorderColor(context)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Row(
                children: [
                  SizedBox(width: 4.w),
                  PaywallRadioButton(isSelected: isSelected),
                  SizedBox(width: 12.sp),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 4.h,
                    children: [
                      Text(product.period, style: context.textStyles.fs16W600),
                      Text(
                        _getSubtitle(context),
                        style: context.textStyles.fs12W400.copyWith(
                          color: context.colors.grayLight,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    _getPriceText(context),
                    textAlign: TextAlign.end,
                    style: context.textStyles.fs16W600,
                  ),
                ],
              ),
              if (product.isBestValue)
                Positioned(
                  top: -28.h,
                  right: 0,
                  left: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: context.colors.redLight,
                          borderRadius: context.radius.radius12,
                        ),
                        child: Text(
                          context.tr.paywall.bestValue,
                          textAlign: TextAlign.center,
                          style: context.textStyles.fs12W500.copyWith(
                            color: context.colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
