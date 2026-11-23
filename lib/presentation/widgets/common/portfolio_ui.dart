import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/link.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/theme/theme_cubit.dart';
import '../../../core/utils/responsive_helper.dart';
import 'glass_card.dart';

class ContentWidth extends StatelessWidget {
  const ContentWidth({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.topCenter,
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: PortfolioLayout.maxWidth),
      child: SizedBox(width: double.infinity, child: child),
    ),
  );
}

class SectionFrame extends StatelessWidget {
  const SectionFrame({
    super.key,
    required this.child,
    this.padding,
    this.lighting,
    this.etched = false,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Alignment? lighting;
  final bool etched;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final frame = Padding(
          padding:
              padding ??
              EdgeInsets.symmetric(
                horizontal: PortfolioLayout.gutter(width),
                vertical: PortfolioLayout.sectionSpace(width),
              ),
          child: ContentWidth(child: child),
        );
        if (lighting case final alignment?) {
          return GlassAtmosphere(
            alignment: alignment,
            etched: etched,
            child: frame,
          );
        }
        return frame;
      },
    );
  }
}

class SectionHeading extends StatelessWidget {
  const SectionHeading({super.key, required this.title, this.description});

  final String title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final headingSize = constraints.maxWidth < PortfolioLayout.compact
            ? 33.0
            : 48.0;
        return Reveal(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Semantics(
                container: true,
                header: true,
                headingLevel: 2,
                child: WordFitText(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontSize: headingSize,
                    letterSpacing: -1.25,
                    height: 1.12,
                  ),
                ),
              ),
              if (description case final description?) ...[
                const SizedBox(height: 12),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Text(description, style: theme.textTheme.bodyLarge),
                ),
              ],
              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }
}

/// Keeps words intact when a title meets a narrow column or enlarged text.
class WordFitText extends StatelessWidget {
  const WordFitText(this.text, {super.key, this.style, this.compactText});

  static final _spaces = RegExp(r'\s+');

  final String text;
  final TextStyle? style;
  final String? compactText;

  @override
  Widget build(BuildContext context) {
    final resolvedStyle = DefaultTextStyle.of(context).style.merge(style);
    final scaler = MediaQuery.textScalerOf(context);
    final direction = Directionality.of(context);
    final locale = Localizations.maybeLocaleOf(context);
    final fontSize = resolvedStyle.fontSize ?? 14;

    return LayoutBuilder(
      builder: (context, constraints) {
        final available = constraints.maxWidth;
        if (!available.isFinite ||
            available <= 0 ||
            (available >= 380 && scaler.scale(fontSize) <= fontSize)) {
          return Text(text, style: style);
        }

        var display = text;
        var words = text.split(_spaces).join('\n');
        final painter = TextPainter(
          textDirection: direction,
          textScaler: scaler,
          locale: locale,
        );
        double measure(double size) {
          painter.text = TextSpan(
            text: words,
            style: resolvedStyle.copyWith(fontSize: size),
          );
          painter.layout();
          return painter.width;
        }

        final limit = (available - .5).clamp(0.0, available);
        var fits = measure(fontSize) <= limit;
        final alternative = compactText;
        if (!fits && alternative != null) {
          final label = alternative;
          display = label;
          words = label.split(_spaces).join('\n');
          fits = measure(fontSize) <= limit;
        }

        var fittedSize = fontSize;
        if (!fits) {
          var low = 0.0;
          var high = fontSize;
          for (var step = 0; step < 8; step++) {
            final middle = (low + high) / 2;
            if (measure(middle) <= limit) {
              low = middle;
            } else {
              high = middle;
            }
          }
          fittedSize = low;
        }
        painter.dispose();

        final label = Text(
          display,
          style: resolvedStyle.copyWith(fontSize: fittedSize),
        );
        return display == text
            ? label
            : Semantics(label: text, excludeSemantics: true, child: label);
      },
    );
  }
}

class PortfolioThemeButton extends StatelessWidget {
  const PortfolioThemeButton({super.key, this.color, this.showTooltip = true});

  final Color? color;
  final bool showTooltip;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final label = dark ? 'Switch to light theme' : 'Switch to dark theme';
    return IconButton(
      constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
      tooltip: showTooltip ? label : null,
      onPressed: context.read<ThemeCubit>().toggleTheme,
      color: color,
      icon: Icon(
        dark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
        semanticLabel: showTooltip ? null : label,
      ),
    );
  }
}

class Label extends StatelessWidget {
  const Label(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WordFitText(
      text,
      style: theme.textTheme.labelMedium?.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.15,
        height: 1.4,
      ),
    );
  }
}

class TagList extends StatelessWidget {
  const TagList(this.tags, {super.key});

  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        for (final tag in tags)
          DecoratedBox(
            decoration: BoxDecoration(
              color: colors.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
              child: WordFitText(
                tag,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: colors.onSurface,
                  height: 1.3,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class PortfolioLink extends StatelessWidget {
  const PortfolioLink({super.key, required this.label, required this.url});

  final String label;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Link(
      uri: Uri.parse(url),
      target: url.startsWith('mailto:') ? LinkTarget.self : LinkTarget.blank,
      builder: (context, followLink) => OutlinedButton(
        onPressed: followLink,
        child: Text(label, textAlign: TextAlign.center),
      ),
    );
  }
}

class ResponsiveCards extends StatelessWidget {
  const ResponsiveCards({
    super.key,
    required this.children,
    this.maxColumns = 3,
  });

  final List<Widget> children;
  final int maxColumns;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = PortfolioLayout.gap;
        final width = constraints.maxWidth;
        final columns = math.max(
          1,
          math.min(
            maxColumns,
            ((width + gap) / (PortfolioLayout.cardMin + gap)).floor(),
          ),
        );
        final cardWidth = (width - (columns - 1) * gap) / columns;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final child in children)
              SizedBox(key: child.key, width: cardWidth, child: child),
          ],
        );
      },
    );
  }
}

class Reveal extends StatefulWidget {
  const Reveal({
    super.key,
    required this.child,
    this.order = 0,
    this.immediate = false,
    this.travel = 16,
    this.duration = PortfolioLayout.reveal,
    this.initialOpacity = .58,
  });

  final Widget child;
  final int order;
  final bool immediate;
  final double travel;
  final Duration duration;
  final double initialOpacity;

  @override
  State<Reveal> createState() => _RevealState();
}

class _RevealState extends State<Reveal> {
  final _visibilityKey = UniqueKey();
  bool _seen = false;

  @override
  Widget build(BuildContext context) {
    final reduced = MediaQuery.disableAnimationsOf(context);
    final child = TweenAnimationBuilder<double>(
      duration: reduced ? Duration.zero : widget.duration,
      tween: Tween(
        begin: reduced ? 1 : 0,
        end: reduced || widget.immediate || _seen ? 1 : 0,
      ),
      curve: Interval(
        widget.order.clamp(0, 5) * .105,
        1,
        curve: PortfolioLayout.ease,
      ),
      child: widget.child,
      builder: (context, progress, child) => Opacity(
        opacity: reduced
            ? 1
            : widget.initialOpacity + progress * (1 - widget.initialOpacity),
        child: Transform.translate(
          offset: Offset(0, reduced ? 0 : widget.travel * (1 - progress)),
          transformHitTests: false,
          child: child,
        ),
      ),
    );
    if (widget.immediate || reduced) return child;
    return VisibilityDetector(
      key: _visibilityKey,
      onVisibilityChanged: _seen
          ? null
          : (info) {
              if (mounted &&
                  !_seen &&
                  info.visibleBounds.height >=
                      math.min(20, info.size.height * .10) &&
                  info.visibleFraction > 0) {
                setState(() => _seen = true);
              }
            },
      child: child,
    );
  }
}
