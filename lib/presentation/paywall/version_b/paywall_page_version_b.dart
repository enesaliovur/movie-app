import 'package:boby_ai_case/core/config/app_config.dart';
import 'package:boby_ai_case/core/constants/asset_constants.dart';
import 'package:boby_ai_case/core/extensions/screen_extension.dart';
import 'package:boby_ai_case/core/extensions/theme/build_context_color_ext.dart';
import 'package:boby_ai_case/core/extensions/theme/build_context_text_style_ext.dart';
import 'package:boby_ai_case/data/models/paywall/paywall_feature.dart';

import 'package:boby_ai_case/presentation/paywall/store/paywall_store.dart';
import 'package:boby_ai_case/presentation/paywall/widgets/paywall_button.dart';
import 'package:boby_ai_case/presentation/paywall/widgets/paywall_footer_links.dart';
import 'package:boby_ai_case/presentation/paywall/widgets/paywall_radio_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

part 'widgets/paywall_header.dart';
part 'widgets/paywall_product_selection.dart';
part 'widgets/paywall_feature_list.dart';

class PaywallPageVersionB extends StatelessWidget {
  const PaywallPageVersionB({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: context.screenHeight,
              width: context.screenWidth,
              child: Image.asset(
                AssetConstants.paywallVersionBackground,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: context.screenWidth,
              height: context.screenHeight,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x000F0E0E), Color(0xFF0F0E0E)],
                  stops: [0.0, 0.76],
                ),
              ),
            ),

            SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const PaywallHeader(),
                          SizedBox(height: context.screenHeight * 0.1),
                          Text(
                            AppConfig.appName,
                            style: context.fs24W700.copyWith(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 32.h),
                          const PaywallFeatureList(),
                          SizedBox(height: 40.h),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 20.h,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const PaywallProductSelection(),
                        SizedBox(height: 24.h),
                        const PaywallButton(
                          title: 'Continue',
                          icon: Icons.arrow_forward,
                        ),
                        SizedBox(height: 16.h),
                        const PaywallFooterLinks(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
