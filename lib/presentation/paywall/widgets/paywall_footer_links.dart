import 'package:boby_ai_case/core/extensions/localization/build_context_tr_ext.dart';
import 'package:boby_ai_case/core/extensions/theme/build_context_color_ext.dart';
import 'package:boby_ai_case/core/extensions/theme/build_context_text_style_ext.dart';
import 'package:boby_ai_case/core/shared/widgets/default_animated_container.dart';
import 'package:flutter/material.dart';

class PaywallFooterLinks extends StatelessWidget {
  const PaywallFooterLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _FooterLink(onTap: () {}, text: context.tr.paywall.termsOfUse),
        _FooterLink(onTap: () {}, text: context.tr.paywall.restorePurchase),
        _FooterLink(onTap: () {}, text: context.tr.paywall.privacyPolicy),
      ],
    );
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink({required this.onTap, required this.text});
  final VoidCallback onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return DefaultAnimatedContainer(
      onTap: onTap,
      child: Text(
        text,
        style: context.textStyles.fs8W400.copyWith(color: context.colors.gray),
      ),
    );
  }
}
