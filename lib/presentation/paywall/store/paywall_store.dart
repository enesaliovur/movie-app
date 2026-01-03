import 'package:boby_ai_case/core/enums/paywall_version.dart';
import 'package:boby_ai_case/core/remote_config/i_remote_config_service.dart';
import 'package:boby_ai_case/domain/entities/product/product_entity.dart';
import 'package:mobx/mobx.dart';

part 'paywall_store.g.dart';

class PaywallStore = _PaywallStoreBase with _$PaywallStore;

abstract class _PaywallStoreBase with Store {
  final IRemoteConfigService remoteConfigService;
  @observable
  ObservableList<ProductEntity> products = ObservableList<ProductEntity>();

  @observable
  ProductEntity? selectedProduct;

  @observable
  bool isFreeTrial = true;

  @observable
  PaywallVersion paywallVersion = PaywallVersion.versionA;

  @observable
  bool highlightFreeTrialSwitch = false;

  _PaywallStoreBase(this.remoteConfigService);


  @action
  void init() {
    paywallVersion = remoteConfigService.getPaywallVersion();
    products.addAll([
      ProductEntity.weeklyDummy(),
      ProductEntity.monthlyDummy(),
      ProductEntity.yearlyDummy(),
    ]);
    try {
      selectProduct(products.firstWhere((element) => element.tier == 2));
    } catch (_) {
      if (products.isNotEmpty) selectProduct(products.last);
    }
  }

  @action
  void selectProduct(ProductEntity product) {
    if (paywallVersion.isVersionA && isFreeTrial) {
      if (product.tier != 2) {
        triggerFreeTrialHighlight();
        return;
      }
    }

    selectedProduct = product;
    highlightFreeTrialSwitch = false;
  }

  @action
  void toggleFreeTrial(bool value) {
    isFreeTrial = value;

    if (paywallVersion.isVersionA && value) {
      final yearly = products.firstWhere(
        (p) => p.tier == 2,
        orElse: () => products.first,
      );
      selectedProduct = yearly;
    }
  }

  @action
  void triggerFreeTrialHighlight() {
    highlightFreeTrialSwitch = true;
    Future.delayed(const Duration(milliseconds: 600), () {
      highlightFreeTrialSwitch = false;
    });
  }
}
