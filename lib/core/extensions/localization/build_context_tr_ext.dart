import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension TranslationExtension on BuildContext {
  AppTranslations get tr => AppTranslations();
}

class AppTranslations {
  String get appTitle => 'app_title'.tr();
  HomeTranslations get home => HomeTranslations();
  SearchTranslations get search => SearchTranslations();
  CommonTranslations get common => CommonTranslations();
  OnboardingTranslations get onboarding => OnboardingTranslations();
  PaywallTranslations get paywall => PaywallTranslations();
}

class HomeTranslations {
  String get welcome => 'home.welcome'.tr();
  String get searchHint => 'home.search_hint'.tr();
  String get forYou => 'home.for_you'.tr();
  String get movies => 'home.movies'.tr();
  String get seeAll => 'home.see_all'.tr();
  String get noRecommendations => 'home.no_recommendations'.tr();
  String get noMoviesFound => 'home.no_movies_found'.tr();
}

class SearchTranslations {
  String get title => 'search.title'.tr();
  String get noResults => 'search.no_results'.tr();
  String get error => 'search.error'.tr();
  String get retry => 'search.retry'.tr();
  String get searchHint => 'search.search_hint'.tr();
}

class CommonTranslations {
  String get success => 'common.success'.tr();
  String get error => 'common.error'.tr();
  String get loading => 'common.loading'.tr();
}

class OnboardingTranslations {
  String get welcome => 'onboarding.welcome'.tr();
  String get thankYou => 'onboarding.thank_you'.tr();
  String get continueToNextStep => 'onboarding.continue_to_next_step'.tr();
  String get chooseMoviesTitle => 'onboarding.choose_movies_title'.tr();
  String get chooseGenresTitle => 'onboarding.choose_genres_title'.tr();
  String get continueBtn => 'onboarding.continue_btn'.tr();
  String get getStartedBtn => 'onboarding.get_started_btn'.tr();
}

class PaywallTranslations {
  String get monthlyTitle => 'paywall.monthly_title'.tr();
  String monthlyPrice(String price) =>
      'paywall.monthly_price'.tr(namedArgs: {'price': price});
  String monthlySubPrice(String price) =>
      'paywall.monthly_sub_price'.tr(namedArgs: {'price': price});
  String get yearlyTitle => 'paywall.yearly_title'.tr();
  String yearlyPrice(String price) =>
      'paywall.yearly_price'.tr(namedArgs: {'price': price});
  String yearlySubPrice(String price) =>
      'paywall.yearly_sub_price'.tr(namedArgs: {'price': price});
  String weeklySubPriceFallback(String price) =>
      'paywall.weekly_sub_price_fallback'.tr(namedArgs: {'price': price});
  String get bestValue => 'paywall.best_value'.tr();
  String get termsOfUse => 'paywall.terms_of_use'.tr();
  String get restorePurchase => 'paywall.restore_purchase'.tr();
  String get privacyPolicy => 'paywall.privacy_policy'.tr();
  String get freeTrial => 'paywall.free_trial'.tr();
  String get noPaymentNow => 'paywall.no_payment_now'.tr();
  String get enableFreeTrial => 'paywall.enable_free_trial'.tr();
  String get free => 'paywall.free'.tr();
  String get pro => 'paywall.pro'.tr();
  PaywallFeatureTranslations get features => PaywallFeatureTranslations();
}

class PaywallFeatureTranslations {
  String get unlimited => 'paywall.features.unlimited'.tr();
  String get adFree => 'paywall.features.ad_free'.tr();
  String get offline => 'paywall.features.offline'.tr();
  String get hd => 'paywall.features.hd'.tr();
}
