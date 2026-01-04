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

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const PaywallFreeTrialContainer(),
            SizedBox(height: 24.h),
            for (final product in products) ...[
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: PaywallProductListTile(
                  product: product,
                  isSelected: product == selectedProduct,
                  isHighlight:
                      product != selectedProduct &&
                      paywallStore.highlightOtherItems,
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
