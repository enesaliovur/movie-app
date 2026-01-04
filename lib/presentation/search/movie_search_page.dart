import 'package:auto_route/auto_route.dart';
import 'package:boby_ai_case/core/di/setup_injector.dart';
import 'package:boby_ai_case/core/extensions/localization/build_context_tr_ext.dart';
import 'package:boby_ai_case/core/extensions/theme/build_context_color_ext.dart';
import 'package:boby_ai_case/core/extensions/theme/build_context_radius_ext.dart';
import 'package:boby_ai_case/core/extensions/theme/build_context_text_style_ext.dart';
import 'package:boby_ai_case/core/extensions/visualization/build_context_toast_ext.dart';
import 'package:boby_ai_case/core/failure/failure.dart';
import 'package:boby_ai_case/core/router/app_router.dart';
import 'package:boby_ai_case/core/shared/widgets/default_progress_indicator.dart';
import 'package:boby_ai_case/core/shared/widgets/default_retry_button.dart';
import 'package:boby_ai_case/core/shared/widgets/movie_card.dart';
import 'package:boby_ai_case/presentation/search/store/movie_search_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

part 'widgets/movie_search_bar.dart';
part 'widgets/movie_search_list.dart';

@RoutePage()
class MovieSearchPage extends StatefulWidget {
  const MovieSearchPage({super.key});

  @override
  State<MovieSearchPage> createState() => _MovieSearchPageState();
}

class _MovieSearchPageState extends State<MovieSearchPage> {
  late MovieSearchStore _store;
  late ReactionDisposer _disposer;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _store = getIt<MovieSearchStore>();
    _disposer = reaction<Failure?>((_) => _store.failure, (failure) {
      if (failure != null && mounted) {
        context.showFailureToast();
      }
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (!_store.isLoadMoreLoading && _store.hasNextPage) {
        _store.loadMoreMovies();
      }
    }
  }

  @override
  void dispose() {
    _disposer();
    _store.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<MovieSearchStore>(
      create: (context) => _store,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            context.tr.search.title,
            style: context.textStyles.fs20W600,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(height: 8.sp),
              const MovieSearchBar(),
              SizedBox(height: 16.sp),
              Expanded(
                child: MovieSearchList(scrollController: _scrollController),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
