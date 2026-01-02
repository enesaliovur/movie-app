import 'package:boby_ai_case/core/remote_config/i_remote_config_service.dart';
import 'package:boby_ai_case/data/models/product/product_data.dart';
import 'package:mobx/mobx.dart';

import 'package:boby_ai_case/core/enums/paywall_version.dart';

part 'paywall_store.g.dart';

class PaywallStore = _PaywallStore with _$PaywallStore;

abstract class _PaywallStore with Store {
  _PaywallStore(this._remoteConfigService) {
    _init();
  }

  final IRemoteConfigService _remoteConfigService;

  @observable
  List<ProductData> products = [
    ProductData.weeklyDummy(),
    ProductData.monthlyDummy(),
    ProductData.yearlyDummy(),
  ];

  @observable
  ProductData? selectedProduct;

  @observable
  bool isFreeTrial = true;

  @observable
  bool highlightFreeTrialSwitch = false;

  @observable
  PaywallVersion paywallVersion = PaywallVersion.versionA;

  @action
  void _init() {
    paywallVersion = _remoteConfigService.getPaywallVersion();

    if (products.isNotEmpty) {
      selectedProduct = products.firstWhere(
        (element) => element.tier == 2,
        orElse: () => products.first,
      );
    }
  }

  @action
  void selectProduct(ProductData product) {
    if (paywallVersion.isVersionA && isFreeTrial && product.tier != 2) {
      highlightFreeTrialSwitch = true;
      Future.delayed(const Duration(milliseconds: 300), () {
        setHighlightFreeTrialSwitch(false);
      });
      return;
    }
    selectedProduct = product;
  }

  @action
  void toggleFreeTrial(bool value) {
    isFreeTrial = value;
    if (isFreeTrial) {
      final yearlyProduct = products.firstWhere(
        (p) => p.tier == 2,
        orElse: () => products.last,
      );
      selectedProduct = yearlyProduct;
    }
  }

  @action
  void setHighlightFreeTrialSwitch(bool value) {
    highlightFreeTrialSwitch = value;
  }
}
