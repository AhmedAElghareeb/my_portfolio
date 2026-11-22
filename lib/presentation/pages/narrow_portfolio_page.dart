import 'package:flutter/material.dart';

import '../../core/utils/responsive_helper.dart';
import '../widgets/common/glass_card.dart';
import '../widgets/common/portfolio_ui.dart';

class NarrowPortfolioPage extends StatelessWidget {
  const NarrowPortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gutter = PortfolioLayout.gutter(MediaQuery.sizeOf(context).width);
    return Scaffold(
      body: SafeArea(
        child: GlassAtmosphere(
          alignment: const Alignment(.55, -.75),
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(gutter, 10, gutter, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Semantics(
                      label: 'Ahmed Elghareeb',
                      excludeSemantics: true,
                      child: WordFitText(
                        'AE',
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    const PortfolioThemeButton(showTooltip: false),
                  ],
                ),
                const SizedBox(height: 20),
                GlassCard(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 16,
                  ),
                  interactive: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WordFitText(
                        'Ahmed Elghareeb',
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      Semantics(
                        container: true,
                        header: true,
                        headingLevel: 1,
                        child: WordFitText(
                          'Widen your window',
                          style: theme.textTheme.titleLarge,
                        ),
                      ),
                      const SizedBox(height: 8),
                      WordFitText(
                        'Make the window wider to see the full portfolio.',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
