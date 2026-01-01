part of '../pages/home_page.dart';

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
      child: ScalingContainer(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: isSelected ? context.redLight : context.white,
            borderRadius: BorderRadius.circular(100.w),
            border: Border.all(
              color: isSelected ? context.redLight : context.gray,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isSelected) ...[
                Padding(
                  padding: EdgeInsets.only(right: 4.w),
                  child: Icon(Icons.check, color: context.white, size: 16.sp),
                ),
              ],
              Center(
                child: Text(
                  name,
                  style: context.fs16W400.copyWith(
                    color: isSelected ? context.white : context.black,
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
