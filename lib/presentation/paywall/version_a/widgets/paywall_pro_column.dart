part of '../paywall_page_version_a.dart';

class PaywallProColumn extends StatefulWidget {
  const PaywallProColumn({super.key});

  @override
  State<PaywallProColumn> createState() => _PaywallProColumnState();
}

class _PaywallProColumnState extends State<PaywallProColumn> {
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

    const duration = Duration(milliseconds: 200); 
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
          const ProHeader(),
          SizedBox(height: 12.h),
          ...List.generate(PaywallFeatures.all.length, (index) {
            final feature = PaywallFeatures.all[index];
            final isFeatureIncluded = feature.isAvailableForTier(_visualTier);

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PaywallFeatureStatusCell(
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

class ProHeader extends StatelessWidget {
  const ProHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const ProGradient(),
        Text(context.tr.paywall.pro, style: context.textStyles.fs16W600),
        const ProGradient(),
      ],
    );
  }
}

class ProGradient extends StatelessWidget {
  const ProGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.h,
      width: 22.w,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            context.colors.redLight,
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}
