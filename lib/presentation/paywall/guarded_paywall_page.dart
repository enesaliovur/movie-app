import 'package:boby_ai_case/core/di/setup_injector.dart';
import 'package:boby_ai_case/core/enums/paywall_version.dart';
import 'package:boby_ai_case/presentation/paywall/store/paywall_store.dart';
import 'package:boby_ai_case/presentation/paywall/version_a/paywall_page_version_a.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:boby_ai_case/presentation/paywall/version_b/paywall_page_version_b.dart';
import 'package:provider/provider.dart';

class GuardedPaywallPage extends StatelessWidget {
  static const String path = '/paywall';

  const GuardedPaywallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<PaywallStore>(
      create: (context) => getIt<PaywallStore>(),
      child: Observer(
        builder: (context) {
          final store = context.read<PaywallStore>();
          final paywallVersion = store.paywallVersion;
          switch (paywallVersion) {
            case PaywallVersion.versionA:
              return const PaywallPageVersionA();
            case PaywallVersion.versionB:
              return const PaywallPageVersionB();
          }
        },
      ),
    );
  }
}
