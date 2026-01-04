import 'dart:async';
import 'package:flutter/material.dart';
import 'package:matrix4_transform/matrix4_transform.dart';

class DefaultAnimatedContainer extends StatefulWidget {
  const DefaultAnimatedContainer({
    super.key,
    required this.child,
    this.onTap,
    this.onDoubleTap,
    this.constraints,
    this.scale = 0.96,
    this.onLongPress,
    this.shrinkWrap = false,
  });

  final Widget child;
  final BoxConstraints? constraints;
  final double scale;
  final bool shrinkWrap;

  final Function()? onTap;
  final Function()? onDoubleTap;
  final Function()? onLongPress;

  @override
  DefaultAnimatedContainerState createState() =>
      DefaultAnimatedContainerState();
}

class DefaultAnimatedContainerState extends State<DefaultAnimatedContainer> {
  final _debounceDuration = const Duration(milliseconds: 200);
  final _scaleDuration = const Duration(milliseconds: 100);
  final _cancelDuration = const Duration(milliseconds: 110);
  final _animationDuration = const Duration(milliseconds: 100);
  bool _isEnabled = true;

  bool isScale = false;
  Size measureSize = Size.zero;

  @override
  Widget build(BuildContext context) {
    return MeasureSize(
      onChange: (size) {
        measureSize = size;
      },
      child: InkWell(
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        onTap: () async {
          await Future.delayed(_scaleDuration);
          if (!mounted) return;
          setState(() => isScale = false);

          if (!_isEnabled) return;
          _isEnabled = false;
          if (widget.onTap != null) widget.onTap!();
          Timer(_debounceDuration, () => _isEnabled = true);
        },
        onTapDown: (x) {
          if (!mounted) return;
          setState(() => isScale = true);
        },
        onTapCancel: () async {
          await Future.delayed(_cancelDuration);
          if (!mounted) return;
          setState(() => isScale = false);
        },
        onDoubleTap: widget.onDoubleTap,
        onLongPress: widget.onLongPress,
        child: AnimatedContainer(
          constraints: widget.constraints,
          alignment: widget.shrinkWrap ? null : FractionalOffset.center,
          duration: _animationDuration,
          transform: Matrix4Transform()
              .scale(
                isScale ? widget.scale : 1,
                origin: Offset(measureSize.width / 2, measureSize.height / 2),
              )
              .matrix4,
          child: widget.child,
        ),
      ),
    );
  }
}

class MeasureSize extends StatefulWidget {
  final Widget child;
  final OnWidgetSizeChange onChange;

  const MeasureSize({super.key, required this.onChange, required this.child});

  @override
  MeasureSizeState createState() => MeasureSizeState();
}

class MeasureSizeState extends State<MeasureSize> {
  Size? oldSize;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(getSize);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: widget.child);
  }

  void getSize(Duration _) {
    if (!mounted) return;
    final newSize = context.size;

    if (newSize == null) return;
    if (oldSize == newSize) return;

    oldSize = newSize;
    widget.onChange(newSize);
  }
}

typedef OnWidgetSizeChange = void Function(Size size);
