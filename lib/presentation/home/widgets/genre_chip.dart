part of '../home_page.dart';

class GenreChip extends StatelessWidget {
  const GenreChip({
    super.key,
    required this.name,
    required this.isSelected,
    required this.onTap,
  });

  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: DefaultAnimatedContainer(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: isSelected ? context.colors.redLight : context.colors.white,
            borderRadius: context.radius.radius100,
            border: Border.all(
              color: isSelected
                  ? context.colors.redLight
                  : context.colors.grayLight,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isSelected) ...[
                Padding(
                  padding: EdgeInsets.only(right: 4.w),
                  child: Icon(
                    Icons.check,
                    color: context.colors.white,
                    size: 16.sp,
                  ),
                ),
              ],
              Center(
                child: Text(
                  name,
                  style: context.textStyles.fs16W400.copyWith(
                    color: isSelected
                        ? context.colors.white
                        : context.colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
