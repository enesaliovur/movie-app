part of '../paywall_page_version_b.dart';

class PaywallProductSelection extends StatefulWidget {
  const PaywallProductSelection({super.key});

  @override
  State<PaywallProductSelection> createState() =>
      _PaywallProductSelectionState();
}

class _PaywallProductSelectionState extends State<PaywallProductSelection> {
  @override
  Widget build(BuildContext context) {
    final store = context.read<PaywallStore>();

    return Observer(
      builder: (_) {
        final monthlyProduct = store.products.firstWhere(
          (p) => p.tier == 1,
          orElse: () => store.products.first,
        );
        final yearlyProduct = store.products.firstWhere(
          (p) => p.tier == 2,
          orElse: () => store.products.last,
        );

        return Column(
          spacing: 24.h,
          children: [
            _ProductCard(
              title: context.tr.paywall.monthlyTitle,
              price: context.tr.paywall.monthlyPrice(monthlyProduct.price),
              subPrice: context.tr.paywall.monthlySubPrice(
                monthlyProduct.weeklyPrice,
              ),
              isSelected:
                  store.selectedProduct?.tier == 1, // Monthly tier = 1 assumed
              onTap: () {
                store.selectProduct(monthlyProduct);
              },
            ),
            _ProductCard(
              title: context.tr.paywall.yearlyTitle,
              price: context.tr.paywall.yearlyPrice(yearlyProduct.price),
              subPrice: context.tr.paywall.yearlySubPrice(
                yearlyProduct.weeklyPrice,
              ),
              isSelected:
                  store.selectedProduct?.tier == 2, // Yearly tier = 2 assumed
              isBestValue: true,
              onTap: () {
                store.selectProduct(yearlyProduct);
              },
            ),
          ],
        );
      },
    );
  }
}

class _ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String subPrice;
  final bool isSelected;
  final bool isBestValue;
  final VoidCallback onTap;

  const _ProductCard({
    required this.title,
    required this.price,
    required this.subPrice,
    required this.isSelected,
    required this.onTap,
    this.isBestValue = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: context.screenWidth,
            decoration: BoxDecoration(
              borderRadius: context.radius.radius12,
              border: Border.all(
                color: isSelected ? context.colors.redLight : context.colors.white,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Row(
                children: [
                  SizedBox(width: 4.w),
                  PaywallRadioButton(isSelected: isSelected),
                  SizedBox(width: 12.sp),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: context.textStyles.fs16W600.copyWith(color: Colors.white),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        subPrice,
                        style: context.textStyles.fs12W400.copyWith(color: context.colors.gray),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    price,
                    textAlign: TextAlign.end,
                    style: context.textStyles.fs16W600.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          if (isBestValue)
            Positioned(
              top: -12.h,
              right: 20.w,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: context.colors.redLight,
                  borderRadius: context.radius.radius12,
                ),
                child: Text(
                  context.tr.paywall.bestValue,
                  textAlign: TextAlign.center,
                  style: context.textStyles.fs12W400.copyWith(
                    color: context.colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
