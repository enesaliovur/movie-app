import 'package:boby_ai_case/core/config/app_config.dart';

import 'package:boby_ai_case/core/extensions/screen_extension.dart';
import 'package:boby_ai_case/core/extensions/localization/build_context_tr_ext.dart';
import 'package:boby_ai_case/core/extensions/theme/build_context_color_ext.dart';
import 'package:boby_ai_case/core/extensions/theme/build_context_text_style_ext.dart';
import 'package:boby_ai_case/core/shared/widgets/scaling_container.dart';
import 'package:boby_ai_case/data/models/paywall/paywall_feature.dart';
import 'package:boby_ai_case/data/models/product/product_data.dart';
import 'package:boby_ai_case/presentation/home/pages/home_page.dart';
import 'package:boby_ai_case/presentation/paywall/store/paywall_store.dart';
import 'package:boby_ai_case/presentation/paywall/widgets/paywall_button.dart';
import 'package:boby_ai_case/presentation/paywall/widgets/paywall_footer_links.dart';
import 'package:boby_ai_case/presentation/paywall/widgets/paywall_radio_button.dart';
import 'package:boby_ai_case/presentation/paywall/widgets/paywall_renewal_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:mobx/mobx.dart';

part 'widgets/paywall_features_table.dart';
part 'widgets/paywall_products_view.dart';
part 'widgets/paywall_purchase_button.dart';

class PaywallPageVersionA extends StatelessWidget {
  const PaywallPageVersionA({super.key, required this.fromOnboarding});
  final bool fromOnboarding;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      Text(AppConfig.appName, style: context.fs24W700),
                      SizedBox(height: 12.h),
                      const PaywallFeaturesTable(),
                      SizedBox(height: 28.h),
                      const _BottomSection(),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 8.w,
                child: IconButton(
                  icon: Icon(Icons.close, color: context.gray, size: 24.sp),
                  onPressed: () {
                    if (fromOnboarding) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductsSection extends StatelessWidget {
  const _ProductsSection();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [PaywallProductsView(), PaywallRenewalInfo()],
    );
  }
}

class _BottomSection extends StatelessWidget {
  const _BottomSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _ProductsSection(),
        SizedBox(height: 12.h),
        const PaywallPurchaseButton(),
        SizedBox(height: 20.h),
        const PaywallFooterLinks(),
      ],
    );
  }
}
