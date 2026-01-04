import 'package:auto_route/auto_route.dart';
import 'package:boby_ai_case/core/di/setup_injector.dart';
import 'package:boby_ai_case/core/extensions/localization/build_context_tr_ext.dart';
import 'package:boby_ai_case/core/extensions/theme/build_context_color_ext.dart';
import 'package:boby_ai_case/core/extensions/theme/build_context_radius_ext.dart';
import 'package:boby_ai_case/core/extensions/theme/build_context_text_style_ext.dart';
import 'package:boby_ai_case/core/router/app_router.dart';
import 'package:boby_ai_case/core/shared/widgets/default_progress_indicator.dart';
import 'package:boby_ai_case/core/shared/widgets/default_retry_button.dart';
import 'package:boby_ai_case/core/shared/widgets/movie_card.dart';
import 'package:boby_ai_case/core/shared/widgets/scaling_container.dart';
import 'package:boby_ai_case/domain/entities/movie/movie_entity.dart';
import 'package:boby_ai_case/presentation/common/movie/store/movie_store.dart';
import 'package:boby_ai_case/presentation/home/store/recommendation_store.dart';
import 'package:boby_ai_case/core/extensions/visualization/build_context_toast_ext.dart';
import 'package:boby_ai_case/core/failure/failure.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

part 'widgets/home_page_for_you_section.dart';
part 'widgets/home_page_movies_section.dart';
part 'widgets/genre_chip.dart';
part 'widgets/category_section.dart';
part 'widgets/home_page_search_bar.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final RecommendationStore _recommendationStore;

  late final List<ReactionDisposer> _disposers;

  @override
  void initState() {
    super.initState();
    _recommendationStore = getIt<RecommendationStore>();
    _setupReactions();
  }

  void _setupReactions() {
    _disposers = [
      reaction<Failure?>((_) => _recommendationStore.failure, (failure) {
        if (failure != null && mounted) {
          context.showFailureToast();
        }
      }),
    ];
  }

  @override
  void dispose() {
    for (final disposer in _disposers) {
      disposer();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomePageForYouSection(),
              SizedBox(height: 32.h),
              Divider(color: context.grayDark, height: 0.5),
              SizedBox(height: 16.h),
              const Expanded(child: HomePageMoviesSection()),
            ],
          ),
        ),
      ),
    );
  }
}
