enum AppFlavor { dev, staging, prod }

class FlavorConfig {
  final AppFlavor flavor;
  final String appName;
  final String baseUrl;
  final bool enableLogging;

  FlavorConfig._({
    required this.flavor,
    required this.appName,
    required this.baseUrl,
    required this.enableLogging,
  });

  static FlavorConfig? _instance;

  static FlavorConfig get instance {
    assert(_instance != null, 'FlavorConfig must be initialized first');
    return _instance!;
  }

  static void initialize({
    required AppFlavor flavor,
    required String appName,
    required String baseUrl,
    bool enableLogging = false,
  }) {
    _instance = FlavorConfig._(
      flavor: flavor,
      appName: appName,
      baseUrl: baseUrl,
      enableLogging: enableLogging,
    );
  }

  bool get isDev => flavor == AppFlavor.dev;

  bool get isStaging => flavor == AppFlavor.staging;

  bool get isProd => flavor == AppFlavor.prod;
}
