import 'package:flutter/material.dart';

import '../../../core/utils/responsive_helper.dart';
import '../../../data/portfolio_data.dart';
import '../common/glass_card.dart';
import '../common/portfolio_ui.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.onExplore,
    required this.onContact,
  });

  final VoidCallback onExplore;
  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final viewport = MediaQuery.sizeOf(context);
    final compact = viewport.width < PortfolioLayout.minFullWidth;
    final gutter = PortfolioLayout.gutter(viewport.width);
    final sectionSpace = PortfolioLayout.sectionSpace(viewport.width);
    return SectionFrame(
      lighting: const Alignment(.72, -.76),
      padding: EdgeInsets.fromLTRB(
        gutter,
        viewport.height < PortfolioLayout.shortHeight ? 30 : sectionSpace,
        gutter,
        sectionSpace * .75,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final split = constraints.maxWidth >= PortfolioLayout.split;
          final headingSize = compact
              ? (constraints.maxWidth * .12).clamp(28.0, 34.0)
              : (constraints.maxWidth * .12).clamp(37.0, 76.0);
          final intro = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Reveal(
                immediate: true,
                initialOpacity: .76,
                travel: 10,
                child: Label('FLUTTER / MOBILE DEVELOPER  ·  EGYPT'),
              ),
              const SizedBox(height: 20),
              Reveal(
                immediate: true,
                order: 1,
                initialOpacity: .78,
                travel: 20,
                child: Semantics(
                  container: true,
                  header: true,
                  headingLevel: 1,
                  child: WordFitText(
                    compact ? 'Ahmed Elghareeb' : PortfolioData.name,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontSize: headingSize,
                      height: 1.03,
                      letterSpacing: split ? -4 : -1.6,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 23),
              Reveal(
                immediate: true,
                order: 2,
                initialOpacity: .68,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 580),
                  child: Text(
                    'I build and ship Flutter apps for iOS and Android, from digital wallets and ride-hailing to logistics and commerce. My work spans app architecture, service integration, and store releases.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontSize: split ? 18 : 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  Reveal(
                    immediate: true,
                    order: 3,
                    initialOpacity: .82,
                    travel: 10,
                    child: FilledButton(
                      onPressed: onExplore,
                      child: const Text('Explore My Work'),
                    ),
                  ),
                  Reveal(
                    immediate: true,
                    order: 4,
                    initialOpacity: .78,
                    travel: 10,
                    child: OutlinedButton(
                      onPressed: onContact,
                      child: const Text('Get In Touch'),
                    ),
                  ),
                ],
              ),
            ],
          );

          final stats = GlassCard(
            padding: EdgeInsets.zero,
            interactive: false,
            child: CustomPaint(
              painter: _GridPainter(colors.primary.withValues(alpha: .09)),
              child: Padding(
                padding: EdgeInsets.all(split ? 28 : 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (final (index, (value, label))
                        in PortfolioData.stats.indexed) ...[
                      if (index > 0)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Divider(height: 1),
                        ),
                      Reveal(
                        order: index + 2,
                        travel: 10,
                        initialOpacity: .72,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              value,
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontSize: split ? 38 : 30,
                                color: colors.primary,
                                height: 1.12,
                                letterSpacing: -1.2,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(label, style: theme.textTheme.bodyMedium),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );

          if (split) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 7, child: intro),
                const SizedBox(width: 56),
                Expanded(flex: 3, child: stats),
              ],
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [intro, const SizedBox(height: 32), stats],
          );
        },
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  const _GridPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    for (var line = 26.0; line < size.width - 12; line += 26) {
      canvas.drawLine(Offset(line, 12), Offset(line, size.height - 12), paint);
    }
    for (var line = 26.0; line < size.height - 12; line += 26) {
      canvas.drawLine(Offset(12, line), Offset(size.width - 12, line), paint);
    }
  }

  @override
  bool shouldRepaint(_GridPainter oldDelegate) => oldDelegate.color != color;
}
