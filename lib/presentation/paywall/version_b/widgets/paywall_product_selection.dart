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
        return Column(
          spacing: 24.h,
          children: [
            _ProductCard(
              title: "Monthly",
              price: "\$11.99/month",
              subPrice: "\$2.99 / week",
              isSelected:
                  store.selectedProduct?.tier == 1, // Monthly tier = 1 assumed
              onTap: () {
                // Find monthly product
                final product = store.products.firstWhere(
                  (p) => p.tier == 1,
                  orElse: () => store.products.first,
                );
                store.selectProduct(product);
              },
            ),
            _ProductCard(
              title: "Yearly",
              price: "\$44.99/month",
              subPrice: "\$0.96 / week",
              isSelected:
                  store.selectedProduct?.tier == 2, // Yearly tier = 2 assumed
              isBestValue: true,
              onTap: () {
                // Find yearly product
                final product = store.products.firstWhere(
                  (p) => p.tier == 2,
                  orElse: () => store.products.last,
                );
                store.selectProduct(product);
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
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? context.redLight : context.white,
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
                        style: context.fs16W600.copyWith(color: Colors.white),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        subPrice,
                        style: context.fs12W400.copyWith(color: context.gray),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    price,
                    textAlign: TextAlign.end,
                    style: context.fs16W600.copyWith(color: Colors.white),
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
                  color: context.redLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Best Value",
                  textAlign: TextAlign.center,
                  style: context.fs12W400.copyWith(
                    color: context.white,
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
