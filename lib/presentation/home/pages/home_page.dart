import 'package:boby_ai_case/core/di/setup_injector.dart';
import 'package:boby_ai_case/core/extensions/theme/build_context_color_ext.dart';
import 'package:boby_ai_case/core/extensions/theme/build_context_radius_ext.dart';
import 'package:boby_ai_case/core/extensions/theme/build_context_text_style_ext.dart';
import 'package:boby_ai_case/core/shared/widgets/default_retry_button.dart';
import 'package:boby_ai_case/core/shared/widgets/movie_card.dart';
import 'package:boby_ai_case/core/shared/widgets/scaling_container.dart';
import 'package:boby_ai_case/data/models/movie/movie_data.dart';
import 'package:boby_ai_case/presentation/common/movie/store/movie_store.dart';
import 'package:boby_ai_case/presentation/home/store/recommendation_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

part '../widgets/home_page_for_you_section.dart';
part '../widgets/home_page_movies_section.dart';
part '../widgets/genre_chip.dart';
part '../widgets/category_section.dart';

class HomePage extends StatelessWidget {
  static const String path = '/home';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            spacing: 12.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              HomePageForYouSection(),
              Expanded(child: HomePageMoviesSection()),
            ],
          ),
        ),
      ),
    );
  }
}
