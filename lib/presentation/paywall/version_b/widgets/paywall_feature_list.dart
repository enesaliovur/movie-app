part of '../paywall_page_version_b.dart';

class PaywallFeatureList extends StatelessWidget {
  const PaywallFeatureList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFeature(context, context.tr.paywall.features.unlimited),
          _buildFeature(context, context.tr.paywall.features.adFree),
          _buildFeature(context, context.tr.paywall.features.offline),
          _buildFeature(context, context.tr.paywall.features.hd),
        ],
      ),
    );
  }

  Widget _buildFeature(BuildContext context, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check, color: context.colors.white, size: 20.sp),
          SizedBox(width: 12.w),
          Flexible(
            child: Text(
              text,
              style: context.textStyles.fs16W600,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
  }

