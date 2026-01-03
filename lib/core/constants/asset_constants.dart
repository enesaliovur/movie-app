import 'package:boby_ai_case/core/config/app_flavor.dart';

class AssetConstants {
  AssetConstants._();

  // Fonts
  static const String fontFamilyInter = 'Inter';

  // App Icons per flavor
  static const String _imageAppIconDev = 'assets/app_icon_dev.png';
  static const String _imageAppIconStaging = 'assets/app_icon_staging.png';
  static const String _imageAppIconProd = 'assets/app_icon_prod.png';

  /// Returns the app icon based on current flavor
  static String get imageAppIcon {
    switch (FlavorConfig.instance.flavor) {
      case AppFlavor.dev:
        return _imageAppIconDev;
      case AppFlavor.staging:
        return _imageAppIconStaging;
      case AppFlavor.prod:
        return _imageAppIconProd;
    }
  }

  // Paywall
  static const String paywallVersionBackground =
      'assets/paywall/paywall_version_b_bg.png';
}
