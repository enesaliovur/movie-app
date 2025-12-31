import 'package:boby_ai_case/core/config/app_config.dart';
import 'package:boby_ai_case/core/constants/asset_constants.dart';
import 'package:boby_ai_case/core/extensions/theme/build_context_color_ext.dart';
import 'package:boby_ai_case/core/extensions/theme/build_context_text_style_ext.dart';
import 'package:boby_ai_case/presentation/splash/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          title: AppConfig.appName,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: context.black,
            fontFamily: AssetConstants.fontFamilyInter,
            appBarTheme: AppBarTheme(
              backgroundColor: context.black,
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle.light,
              titleTextStyle: context.fs16W600,
              iconTheme: IconThemeData(color: context.white),
            ),
          ),
          home: const SplashPage(),
        );
      },
    );
  }
}
