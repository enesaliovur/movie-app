part of '../paywall_page_version_a.dart';

class PaywallFeaturesTable extends StatelessWidget {
  const PaywallFeaturesTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(child: _FeatureNamesColumn()),
        const _FreeColumn(),
        SizedBox(width: 12.w),
        const _ProColumn(),
      ],
    );
  }
}

class _FeatureNamesColumn extends StatelessWidget {
  const _FeatureNamesColumn();

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Match Pro Column's vertical padding (8) + border (1) = 9
      padding: EdgeInsets.symmetric(vertical: 9.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Use invisible _ProHeader to match height exactly (1.h + Text + 1.h)
          const Opacity(opacity: 0, child: _ProHeader()),
          SizedBox(height: 12.h),
          ...List.generate(PaywallFeatures.all.length, (index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _FeatureNameCell(name: PaywallFeatures.all[index].name),
                if (index != PaywallFeatures.all.length - 1)
                  SizedBox(height: 16.h),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class _FeatureNameCell extends StatelessWidget {
  const _FeatureNameCell({required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.w, // Match Status Icon Height (20)
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(name, style: context.textStyles.fs14W600),
      ),
    );
  }
}

class _FreeColumn extends StatelessWidget {
  const _FreeColumn();

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Match Pro Column's vertical padding (8) + border (1) = 9
      padding: EdgeInsets.symmetric(vertical: 9.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Manually match _ProHeader height: 1.h (line) + Text + 1.h (line)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 1.h),
              Text(context.tr.paywall.free, style: context.textStyles.fs16W600),
              SizedBox(height: 1.h),
            ],
          ),
          SizedBox(height: 12.h),
          ...List.generate(PaywallFeatures.all.length, (index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _FeatureStatusCell(
                  isAvailable: PaywallFeatures.all[index].freeAccess,
                ),
                if (index != PaywallFeatures.all.length - 1)
                  SizedBox(height: 16.h),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class _ProColumn extends StatefulWidget {
  const _ProColumn();

  @override
  State<_ProColumn> createState() => _ProColumnState();
}

class _ProColumnState extends State<_ProColumn> {
  final Map<int, GlobalKey> _iconKeys = {};
  late ReactionDisposer _disposer;
  int _visualTier = 0;
  PaywallStore? _store;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < PaywallFeatures.all.length; i++) {
      _iconKeys[i] = GlobalKey();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _store = context.read<PaywallStore>();
      _visualTier = _store?.selectedProduct?.tier ?? 0;
      setState(() {});

      _disposer = reaction<int?>((_) => _store?.selectedProduct?.tier, (
        newTier,
      ) {
        if (newTier == null) return;
        _handleTierChange(_visualTier, newTier);
      });
    });
  }

  @override
  void dispose() {
    _disposer();
    super.dispose();
  }

  void _handleTierChange(int oldTier, int newTier) async {
    if (oldTier == 1 && newTier == 0) {
      await _playFlightAnimation(fromIndex: 3, toIndex: 2);
    } else if (oldTier == 0 && newTier == 1) {
      await _playFlightAnimation(fromIndex: 2, toIndex: 3);
    }

    if (mounted) {
      setState(() {
        _visualTier = newTier;
      });
    }
  }

  Future<void> _playFlightAnimation({
    required int fromIndex,
    required int toIndex,
  }) async {
    final fromKey = _iconKeys[fromIndex];
    final toKey = _iconKeys[toIndex];
    if (fromKey?.currentContext == null || toKey?.currentContext == null) {
      return;
    }

    final overlay = Overlay.of(context);
    final renderBoxFrom =
        fromKey!.currentContext!.findRenderObject() as RenderBox;
    final renderBoxTo = toKey!.currentContext!.findRenderObject() as RenderBox;

    final startPos = renderBoxFrom.localToGlobal(Offset.zero);
    var endPos = renderBoxTo.localToGlobal(Offset.zero);

    endPos = Offset(startPos.dx, endPos.dy);

    late OverlayEntry entry;
    final animationNotifier = ValueNotifier<double>(0);

    entry = OverlayEntry(
      builder: (context) {
        return AnimatedBuilder(
          animation: animationNotifier,
          builder: (context, child) {
            final currentPos = Offset.lerp(
              startPos,
              endPos,
              animationNotifier.value,
            )!;
            return Positioned(
              left: currentPos.dx,
              top: currentPos.dy,
              child: SizedBox(
                width: 20.w,
                height: 20.w,
                child: Center(
                  child: Icon(
                    Icons.cancel_rounded,
                    color: context.colors.white,
                    size: 20.sp,
                  ),
                ),
              ),
            );
          },
        );
      },
    );

    overlay.insert(entry);

    // Animate manually
    const duration = Duration(milliseconds: 200); // Faster
    final startTime = DateTime.now();

    await Future.doWhile(() async {
      final elapsed = DateTime.now().difference(startTime);
      if (elapsed >= duration) {
        animationNotifier.value = 1.0;
        return false;
      }
      animationNotifier.value =
          elapsed.inMilliseconds / duration.inMilliseconds;
      await Future.delayed(const Duration(milliseconds: 16));
      return true;
    });

    entry.remove();
    animationNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        borderRadius: context.radius.radius8,
        border: Border.all(color: context.colors.redLight, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const _ProHeader(),
          SizedBox(height: 12.h),
          ...List.generate(PaywallFeatures.all.length, (index) {
            final feature = PaywallFeatures.all[index];
            final isFeatureIncluded = feature.isAvailableForTier(_visualTier);

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _FeatureStatusCell(
                  key: _iconKeys[index],
                  isAvailable: isFeatureIncluded,
                  isAnimated: true,
                ),
                if (index != PaywallFeatures.all.length - 1)
                  SizedBox(height: 16.h),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class _ProHeader extends StatelessWidget {
  const _ProHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const _ProGradient(),
        Text(context.tr.paywall.pro, style: context.textStyles.fs16W600),
        const _ProGradient(),
      ],
    );
  }
}

class _ProGradient extends StatelessWidget {
  const _ProGradient();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.h,
      width: 22.w,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.transparent, context.colors.redLight, Colors.transparent],
        ),
      ),
    );
  }
}

class _FeatureStatusCell extends StatelessWidget {
  const _FeatureStatusCell({
    super.key,
    required this.isAvailable,
    this.isAnimated = false,
  });

  final bool isAvailable;
  final bool isAnimated;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.h,
      width: 20.w,
      child: Center(
        child: isAnimated
            ? _AnimatedStatusIcon(isAvailable: isAvailable)
            : _StatusIcon(isAvailable: isAvailable),
      ),
    );
  }
}

class _StatusIcon extends StatelessWidget {
  const _StatusIcon({required this.isAvailable});
  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    return Icon(
      isAvailable ? Icons.check_circle_rounded : Icons.cancel_rounded,
      color: isAvailable ? context.colors.green : context.colors.white,
      size: 20.sp,
    );
  }
}

class _AnimatedStatusIcon extends StatelessWidget {
  const _AnimatedStatusIcon({required this.isAvailable});
  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    return Icon(
      isAvailable ? Icons.check_circle_rounded : Icons.cancel_rounded,
      key: ValueKey(isAvailable),
      color: isAvailable ? context.colors.green : context.colors.white,
      size: 20.sp,
    );
  }
}
