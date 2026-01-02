import 'package:boby_ai_case/core/enums/paywall_version.dart';
import 'package:boby_ai_case/core/remote_config/i_remote_config_service.dart';

class RemoteConfigService implements IRemoteConfigService {
  @override
  PaywallVersion getPaywallVersion() {
    final isVersionB = DateTime.now().millisecond % 2 == 0;
    return isVersionB ? PaywallVersion.versionB : PaywallVersion.versionA;
  }
}
