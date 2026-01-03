import 'package:boby_ai_case/core/config/app_flavor.dart';

class AppConfig {
  AppConfig._();

  static String get appName => FlavorConfig.instance.appName;

  static String get baseUrl => FlavorConfig.instance.baseUrl;

  static bool get enableLogging => FlavorConfig.instance.enableLogging;

  static AppFlavor get flavor => FlavorConfig.instance.flavor;
}
