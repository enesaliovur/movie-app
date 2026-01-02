part of '../paywall_page_version_b.dart';

class PaywallFeatureList extends StatelessWidget {
  const PaywallFeatureList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: PaywallFeatures.all
            .map(
              (feature) => Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check, color: context.white, size: 20.sp),
                    SizedBox(width: 12.w),
                    Flexible(
                      child: Text(
                        feature.name,
                        style: context.fs16W600,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
