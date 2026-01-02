import 'package:boby_ai_case/core/extensions/theme/build_context_color_ext.dart';
import 'package:boby_ai_case/core/extensions/theme/build_context_text_style_ext.dart';
import 'package:boby_ai_case/core/shared/widgets/scaling_container.dart';
import 'package:flutter/material.dart';

class PaywallFooterLinks extends StatelessWidget {
  const PaywallFooterLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _FooterLink(onTap: () {}, text: 'Terms of Use'),
        _FooterLink(onTap: () {}, text: 'Restore Purchase'),
        _FooterLink(onTap: () {}, text: 'Privacy Policy'),
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
    return ScalingContainer(
      onTap: onTap,
      child: Text(text, style: context.fs8W400.copyWith(color: context.gray)),
    );
  }
}
