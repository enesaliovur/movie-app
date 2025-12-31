import 'package:boby_ai_case/core/extensions/theme/build_context_color_ext.dart';
import 'package:boby_ai_case/core/extensions/theme/build_context_text_style_ext.dart';
import 'package:boby_ai_case/core/shared/widgets/default_button.dart';
import 'package:boby_ai_case/core/shared/widgets/default_progress_indicator.dart';
import 'package:boby_ai_case/presentation/onboarding/store/onboarding_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingContinueButton extends StatelessWidget {
  const OnboardingContinueButton({super.key, required this.onboardingStore});
  final OnboardingStore onboardingStore;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final verifiedLoading = onboardingStore.isProcessing;
        final isValid = onboardingStore.isValid;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: IgnorePointer(
            ignoring: !isValid,
            child: DefaultButton(
              onTap: () => onboardingStore.nextPage(),
              color: isValid ? context.redLight : context.redDark,

              child: verifiedLoading
                  ? const DefaultProgressIndicator()
                  : Center(
                      child: Text(
                        "Continue",
                        style: context.fs16W600.copyWith(
                          color: isValid ? context.labelColor : context.gray,
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
