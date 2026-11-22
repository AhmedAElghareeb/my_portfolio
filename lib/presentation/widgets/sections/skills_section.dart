import 'package:flutter/material.dart';

import '../../../data/portfolio_data.dart';
import '../common/glass_card.dart';
import '../common/portfolio_ui.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  static const _icons = [
    Icons.devices_outlined,
    Icons.account_tree_outlined,
    Icons.hub_outlined,
    Icons.rocket_launch_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SectionFrame(
      lighting: const Alignment(-.66, -.65),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeading(title: 'Technical expertise'),
          ResponsiveCards(
            maxColumns: 2,
            children: [
              for (final (index, category) in PortfolioData.skills.indexed)
                Reveal(
                  order: index,
                  child: GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          _icons[index],
                          color: theme.colorScheme.primary,
                          size: 22,
                        ),
                        const SizedBox(height: 12),
                        WordFitText(
                          category.title,
                          style: theme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          category.description,
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 15),
                        TagList(category.skills),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
