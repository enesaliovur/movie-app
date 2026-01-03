part of '../paywall_page_version_a.dart';

class PaywallPurchaseButton extends StatelessWidget {
  const PaywallPurchaseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final paywallStore = context.read<PaywallStore>();
        final isFreeTrial = paywallStore.isFreeTrial;
        return isFreeTrial
            ? const _AnimatedButton()
            : const PaywallButton(title: 'Unlock MovieAI PRO');
      },
    );
  }
}

class _AnimatedButton extends StatefulWidget {
  const _AnimatedButton();

  @override
  State<_AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<_AnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenWidth;
    final paddingWidth = 20.w;
    final baseWidth = screenWidth - (paddingWidth * 2);

    _widthAnimation = Tween<double>(
      begin: baseWidth,
      end: screenWidth,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    return SizedBox(
      height: 56.h,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return OverflowBox(
            minWidth: 0,
            maxWidth: double.infinity,
            alignment: Alignment.center,

            child: Container(
              width: _widthAnimation.value,
              height: 56.h,
              decoration: BoxDecoration(
                color: context.redLight,
                borderRadius: context.radius12,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.tr.paywall.freeTrial,
                    style: context.fs16W600.copyWith(color: context.white),
                  ),
                  Text(
                    context.tr.paywall.noPaymentNow,
                    style: context.fs16W600,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
