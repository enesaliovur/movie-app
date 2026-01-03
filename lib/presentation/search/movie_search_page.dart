import 'package:boby_ai_case/core/di/setup_injector.dart';
import 'package:boby_ai_case/core/extensions/theme/build_context_color_ext.dart';
import 'package:boby_ai_case/core/extensions/theme/build_context_text_style_ext.dart';
import 'package:boby_ai_case/core/failure/failure.dart';
import 'package:boby_ai_case/core/shared/widgets/default_progress_indicator.dart';
import 'package:boby_ai_case/core/shared/widgets/default_retry_button.dart';
import 'package:boby_ai_case/core/shared/widgets/movie_card.dart';
import 'package:boby_ai_case/domain/entities/movie/paginated_movies_entity.dart';
import 'package:boby_ai_case/presentation/search/store/movie_search_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MovieSearchPage extends StatefulWidget {
  static const String path = '/movie_search';
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
      if (failure != null) {
        Fluttertoast.showToast(
          msg: 'Something went wrong',
          gravity: ToastGravity.TOP,
          textColor: context.white,
          backgroundColor: context.redLight,
        );
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
        appBar: AppBar(title: Text('Movie Search', style: context.fs20W600)),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(height: 8.sp),
              const _SearchBar(),
              SizedBox(height: 16.sp),
              Expanded(
                child: Observer(
                  builder: (context) {
                    final movies = _store.searchResults.movies;
                    final hasFailure = _store.hasFailure;
                    final isLoadMoreLoading = _store.isLoadMoreLoading;
                    final query = _store.lastQuery;
                    final isFetching = _store.isFetching;

                    if (isFetching) {
                      return const Center(child: DefaultProgressIndicator());
                    }

                    if (hasFailure) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DefaultRetryButton(
                              onTap: () {
                                _store.searchMovies(query);
                              },
                            ),
                          ],
                        ),
                      );
                    }

                    if (query.isNotEmpty && movies.isEmpty) {
                      return Center(
                        child: Text(
                          "Movies not found",
                          style: context.fs16W600,
                        ),
                      );
                    }

                    return Column(
                      children: [
                        Expanded(
                          child: GridView.builder(
                            controller: _scrollController,
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 8.h,
                                  crossAxisSpacing: 8.w,
                                  childAspectRatio: 2 / 3,
                                ),
                            itemCount: movies.length,
                            itemBuilder: (context, index) {
                              final movie = movies[index];
                              return MovieCard(
                                imageUrl: movie.posterUrl,
                                borderRadius: BorderRadius.circular(12.sp),
                              );
                            },
                          ),
                        ),
                        if (isLoadMoreLoading)
                          Padding(
                            padding: EdgeInsets.all(8.sp),
                            child: const DefaultProgressIndicator(),
                          ),
                      ],
                    );
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

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  void _onSearch(BuildContext context, {required String query}) {
    final store = context.read<MovieSearchStore>();
    store.searchMovies(query);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.transparent,
      child: TextFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: context.white,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.sp,
            vertical: 8.sp,
          ),
          hintText: 'Search',
          hintStyle: context.fs14W600.copyWith(color: context.grayDark),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.sp),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.sp),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(Icons.search, color: context.grayDark, size: 24.sp),
          suffixIcon: Icon(Icons.mic, color: context.grayDark, size: 24.sp),
        ),
        style: context.fs14W600.copyWith(color: context.black),
        autofocus: true,
        onChanged: (value) {
          _onSearch(context, query: value);
        },
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }
}
