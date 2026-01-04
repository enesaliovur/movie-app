part of '../home_page.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      child: DefaultAnimatedContainer(
        onTap: () {
          context.router.push(const MovieSearchRoute());
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.colors.white,
            borderRadius: context.radius.radius10,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            child: Row(
              children: [
                Icon(Icons.search, color: context.colors.grayDark, size: 24.sp),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    context.tr.search.searchHint,
                    style: context.textStyles.fs17W400.copyWith(
                      color: context.colors.grayDark,
                    ),
                  ),
                ),
                Icon(Icons.mic, color: context.colors.grayDark, size: 24.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
