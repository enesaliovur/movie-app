part of '../movie_search_page.dart';
class MovieSearchBar extends StatelessWidget {
  const MovieSearchBar({super.key});

  void _onSearch(BuildContext context, {required String query}) {
    final store = context.read<MovieSearchStore>();
    store.searchMovies(query);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.transparent,
      child: TextFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: context.colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          hintText: context.tr.search.searchHint,
          hintStyle: context.textStyles.fs17W400.copyWith(
            color: context.colors.grayDark,
          ),
          border: OutlineInputBorder(
            borderRadius: context.radius.radius10,
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: context.radius.radius10,
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: context.colors.grayDark,
            size: 24.sp,
          ),
          suffixIcon: Icon(
            Icons.mic,
            color: context.colors.grayDark,
            size: 24.sp,
          ),
        ),
        style: context.textStyles.fs17W400.copyWith(
          color: context.colors.black,
        ),
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
