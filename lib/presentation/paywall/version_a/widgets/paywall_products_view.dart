part of '../paywall_page_version_a.dart';

class PaywallProductsView extends StatelessWidget {
  const PaywallProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final paywallStore = context.read<PaywallStore>();
        final products = paywallStore.products;
        final selectedProduct = paywallStore.selectedProduct;
        final isFreeTrial = paywallStore.isFreeTrial;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _FreeTrialContainer(
              paywallStore: paywallStore,
              isFreeTrial: isFreeTrial,
            ),
            SizedBox(height: 24.h),
            for (final product in products) ...[
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: _ProductListTile(
                  product: product,
                  isSelected: product == selectedProduct,
                  onTap: () {
                    paywallStore.selectProduct(product);
                  },
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _FreeTrialContainer extends StatelessWidget {
  const _FreeTrialContainer({
    required this.paywallStore,
    required this.isFreeTrial,
  });

  final PaywallStore paywallStore;
  final bool isFreeTrial;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
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
                  color: paywallStore.highlightFreeTrialSwitch
                      ? context.colors.blue.withValues(alpha: 0.2)
                      : context.colors.transparent,
                  borderRadius: context.radius.radius12,
                  border: Border.all(
                    color: paywallStore.highlightFreeTrialSwitch
                        ? context.colors.blue
                        : context.colors.transparent,
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

class _ProductListTile extends StatelessWidget {
  const _ProductListTile({
    required this.product,
    required this.isSelected,
    required this.onTap,
  });
  final ProductEntity product;
  final bool isSelected;
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: context.screenWidth,
        decoration: BoxDecoration(
          borderRadius: context.radius.radius12,
          border: Border.all(
            color: isSelected ? context.colors.redLight : context.colors.white,
          ),
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
                        style: context.textStyles.fs12W400.copyWith(color: context.colors.gray),
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
