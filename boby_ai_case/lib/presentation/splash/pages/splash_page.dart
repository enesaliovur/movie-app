import 'package:boby_ai_case/core/config/app_config.dart';
import 'package:boby_ai_case/core/constants/asset_constants.dart';
import 'package:boby_ai_case/core/di/setup_injector.dart';
import 'package:boby_ai_case/core/extensions/theme/build_context_text_style_ext.dart';
import 'package:boby_ai_case/presentation/home/home_page.dart';
import 'package:boby_ai_case/presentation/onboarding/onboarding_page.dart';
import 'package:boby_ai_case/presentation/onboarding/store/onboarding_store.dart';
import 'package:boby_ai_case/presentation/splash/store/splash_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late final SplashStore _splashStore;
  late final OnboardingStore _onboardingStore;
  late AnimationController _initialAnimationController;
  late AnimationController _pulseAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    _splashStore = getIt<SplashStore>();
    _onboardingStore = getIt<OnboardingStore>();

    _setupAnimations();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    // Initialize splash store (onboarding check)
    await _splashStore.init();

    if (_splashStore.showOnboarding) {
      // Load movies and genres in parallel
      await Future.wait([
        _onboardingStore.getMovies(),
        _onboardingStore.getGenres(),
      ]);
    } else {
      // TODO: home page
    }

    // Check if requests were successful (no failure)
    if (!_onboardingStore.hasError) {
      Future.delayed(const Duration(milliseconds: 500), _handleNavigation);
    }
  }

  void _setupAnimations() {
    _initialAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _initialAnimationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _initialAnimationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _pulseAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _pulseAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _initialAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _pulseAnimationController.repeat(reverse: true);
      }
    });

    _initialAnimationController.forward();
  }

  @override
  void dispose() {
    _initialAnimationController.dispose();
    _pulseAnimationController.dispose();
    super.dispose();
  }

  void _handleNavigation() {
    if (!mounted) return;

    if (_splashStore.showOnboarding) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => Provider(
            create: (_) => _onboardingStore,
            child: const OnboardingPage(),
          ),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Center(
          child: AnimatedBuilder(
            animation: Listenable.merge([
              _initialAnimationController,
              _pulseAnimationController,
            ]),
            builder: (context, child) {
              final isInitialAnimationComplete =
                  _initialAnimationController.status ==
                  AnimationStatus.completed;

              final currentScale = isInitialAnimationComplete
                  ? _pulseAnimation.value
                  : _scaleAnimation.value;

              return FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: AlwaysStoppedAnimation(currentScale),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AssetConstants.imageAppIcon,
                        width: 166.w,
                        height: 166.h,
                        fit: BoxFit.contain,
                      ),
                      Text(AppConfig.appName, style: context.fs24W700),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
