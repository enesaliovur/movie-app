part of '../onboarding_page.dart';

class OnboardingContinueButton extends StatelessWidget {
  const OnboardingContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final onboardingStore = context.read<OnboardingStore>();
        final verifiedLoading = onboardingStore.isProcessing;
        final isValid = onboardingStore.isValid;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: IgnorePointer(
            ignoring: !isValid,
            child: DefaultButton(
              onTap: () => onboardingStore.nextPage(),
              color: isValid ? context.colors.redLight : context.colors.redDark,
              child: verifiedLoading
                  ? const DefaultProgressIndicator()
                  : Center(
                      child: Text(
                        context.tr.onboarding.continueBtn,
                        style: context.textStyles.fs16W600.copyWith(
                          color: isValid
                              ? context.colors.white
                              : context.colors.grayLight,
                        ),
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
