import 'package:boby_ai_case/core/enums/paywall_version.dart';

abstract class IRemoteConfigService {
  PaywallVersion getPaywallVersion();
}
