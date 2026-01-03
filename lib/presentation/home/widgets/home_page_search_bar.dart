part of '../pages/home_page.dart';

class HomePageSearchBar extends StatelessWidget {
  const HomePageSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      child: ScalingContainer(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const MovieSearchPage();
              },
            ),
          );
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.white,
            borderRadius: BorderRadius.circular(12.sp),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            child: Row(
              children: [
                Icon(Icons.search, color: context.grayDark, size: 24.sp),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    "Search",
                    style: context.fs17W400.copyWith(color: context.grayDark),
                  ),
                ),
                Icon(Icons.mic, color: context.grayDark, size: 24.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
