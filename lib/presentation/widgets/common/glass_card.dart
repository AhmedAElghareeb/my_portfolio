import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

import '../../../core/utils/responsive_helper.dart';

class GlassCard extends StatefulWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(22),
    this.radius = PortfolioLayout.radius,
    this.interactive = true,
    this.frosted = false,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final bool interactive;
  final bool frosted;

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  static final _blur = ImageFilter.blur(sigmaX: 7, sigmaY: 7);
  bool _hovered = false;
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final accent = colors.primary;
    final radius = BorderRadius.circular(widget.radius);
    final rail = widget.radius == 0;
    final reduced = MediaQuery.disableAnimationsOf(context);
    final useFrost = widget.frosted && _withinFrostBudget(context);

    final surface = Stack(
      fit: StackFit.passthrough,
      children: [
        if (useFrost) Positioned.fill(child: _frost(radius)),
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: _hovered || _focused ? 1 : 0),
          duration: reduced ? Duration.zero : PortfolioLayout.fast,
          curve: PortfolioLayout.ease,
          child: Padding(
            padding: widget.padding.add(
              rail ? const EdgeInsets.only(bottom: 1) : const EdgeInsets.all(1),
            ),
            child: widget.child,
          ),
          builder: (context, emphasis, child) {
            final rim = Color.lerp(
              colors.outline,
              accent,
              .18 + .30 * emphasis,
            )!;
            final tint = Color.lerp(
              colors.surfaceContainerHighest,
              accent,
              .07 + .07 * emphasis,
            )!;
            final edge = BorderSide(color: rim.withValues(alpha: .86));
            return DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: radius,
                border: rail
                    ? Border(bottom: edge)
                    : Border.fromBorderSide(edge),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [0, .49, 1],
                  colors: [
                    tint.withValues(alpha: .64),
                    colors.surface.withValues(alpha: .76),
                    colors.surface.withValues(alpha: .89),
                  ],
                ),
                boxShadow: [
                  if (emphasis > 0)
                    BoxShadow(
                      color: colors.shadow.withValues(alpha: .19 * emphasis),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                ],
              ),
              child: child,
            );
          },
        ),
        if (widget.radius > 0)
          Positioned(
            top: 0,
            left: widget.radius,
            right: widget.radius,
            height: 1,
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    stops: const [0, .25, .82],
                    colors: [
                      accent.withValues(alpha: 0),
                      accent.withValues(alpha: .32),
                      accent.withValues(alpha: 0),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );

    if (!widget.interactive) return surface;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Focus(
        canRequestFocus: false,
        skipTraversal: true,
        onFocusChange: (focused) {
          if (mounted && _focused != focused)
            setState(() => _focused = focused);
        },
        child: surface,
      ),
    );
  }

  bool _withinFrostBudget(BuildContext context) {
    final viewport = MediaQuery.sizeOf(context);
    final scale = MediaQuery.devicePixelRatioOf(context);
    return viewport.width >= PortfolioLayout.frostWidth &&
        viewport.width * viewport.height * scale * scale <=
            PortfolioLayout.frostMaxPixels;
  }

  Widget _frost(BorderRadius radius) {
    final scrolling = Scrollable.maybeOf(context)?.position.isScrollingNotifier;
    Widget filter({required bool enabled}) => BackdropFilter.grouped(
      filter: _blur,
      enabled: enabled,
      child: const SizedBox.expand(),
    );
    return ClipRRect(
      borderRadius: radius,
      child: scrolling == null
          ? filter(enabled: true)
          : ValueListenableBuilder<bool>(
              valueListenable: scrolling,
              builder: (context, moving, _) => filter(enabled: !moving),
            ),
    );
  }
}

/// Stationary light behind translucent surfaces, painted without blur layers.
class GlassAtmosphere extends StatelessWidget {
  const GlassAtmosphere({
    super.key,
    required this.alignment,
    required this.child,
    this.etched = false,
  });

  final Alignment alignment;
  final Widget child;
  final bool etched;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Stack(
      fit: StackFit.passthrough,
      children: [
        Positioned.fill(
          child: IgnorePointer(
            child: CustomPaint(
              painter: _AtmospherePainter(
                alignment: alignment,
                accent: colors.primary,
                etched: etched,
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}

class _AtmospherePainter extends CustomPainter {
  _AtmospherePainter({
    required this.alignment,
    required this.accent,
    required this.etched,
  });

  final Alignment alignment;
  final Color accent;
  final bool etched;
  Size? _paintSize;
  late Rect _region;
  late Paint _light;
  (Path, Paint)? _grid;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;
    if (size != _paintSize) _preparePaint(size);
    canvas.drawRect(_region, _light);
    if (_grid case (final path, final lines)) canvas.drawPath(path, lines);
  }

  void _preparePaint(Size size) {
    _paintSize = size;
    final bounds = Offset.zero & size;
    final center = alignment.withinRect(bounds);
    final radius = size.shortestSide * .82;
    final lightBounds = Rect.fromCircle(center: center, radius: radius);
    _region = bounds.intersect(lightBounds);
    _light = Paint()
      ..shader = RadialGradient(
        stops: const [0, .46, 1],
        colors: [
          accent.withValues(alpha: .14),
          accent.withValues(alpha: .052),
          accent.withValues(alpha: 0),
        ],
      ).createShader(lightBounds);

    if (!etched) return;
    final lines = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..shader = RadialGradient(
        colors: [accent.withValues(alpha: .12), accent.withValues(alpha: 0)],
      ).createShader(lightBounds);
    final path = Path();
    const step = 34.0;
    for (
      var x = (_region.left / step).ceil() * step;
      x < _region.right;
      x += step
    ) {
      path.moveTo(x + .5, _region.top);
      path.lineTo(x + .5, _region.bottom);
    }
    for (
      var y = (_region.top / step).ceil() * step;
      y < _region.bottom;
      y += step
    ) {
      path.moveTo(_region.left, y + .5);
      path.lineTo(_region.right, y + .5);
    }
    _grid = (path, lines);
  }

  @override
  bool shouldRepaint(_AtmospherePainter oldDelegate) =>
      oldDelegate.alignment != alignment ||
      oldDelegate.accent != accent ||
      oldDelegate.etched != etched;
}
