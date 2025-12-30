import 'package:boby_ai_case/core/extensions/theme/build_context_text_style_ext.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Onboarding Page', style: context.fs12W400)),
    );
  }
}
