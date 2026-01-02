import 'package:boby_ai_case/presentation/paywall/store/paywall_store.dart';

abstract class IRemoteConfigService {
  PaywallVersion getPaywallVersion();
}
