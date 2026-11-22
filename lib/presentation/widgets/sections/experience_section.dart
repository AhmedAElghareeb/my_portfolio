import 'package:flutter/material.dart';

import '../../../core/utils/responsive_helper.dart';
import '../../../data/models/portfolio_models.dart';
import '../../../data/portfolio_data.dart';
import '../common/glass_card.dart';
import '../common/portfolio_ui.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const SectionFrame(
      lighting: Alignment(-.54, -.76),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionHeading(title: 'Experience'),
          _Timeline(),
        ],
      ),
    );
  }
}

class _Timeline extends StatelessWidget {
  const _Timeline();

  @override
  Widget build(BuildContext context) {
    const roles = PortfolioData.experiences;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final (index, role) in roles.indexed)
          _TimelineEntry(
            role: role,
            first: index == 0,
            last: index == roles.length - 1,
          ),
      ],
    );
  }
}

class _TimelineEntry extends StatelessWidget {
  const _TimelineEntry({
    required this.role,
    required this.first,
    required this.last,
  });

  final Experience role;
  final bool first;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Stack(
      children: [
        PositionedDirectional(
          start: 5,
          top: first ? 18 : 0,
          bottom: last ? null : 0,
          width: 1,
          height: last ? 18 : null,
          child: ColoredBox(color: colors.outline),
        ),
        PositionedDirectional(
          start: 0,
          top: 18,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: colors.primary,
              shape: BoxShape.circle,
            ),
            child: const SizedBox.square(dimension: 11),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(start: 25, bottom: last ? 0 : 14),
          child: Reveal(
            travel: 0,
            child: GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Label(role.period),
                  const SizedBox(height: 8),
                  WordFitText(role.role, style: theme.textTheme.titleLarge),
                  const SizedBox(height: 4),
                  WordFitText(role.company, style: theme.textTheme.titleMedium),
                  const SizedBox(height: 10),
                  for (final achievement in role.description)
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 7, right: 8),
                            child: Icon(
                              Icons.circle,
                              size: 5,
                              color: colors.primary,
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: PortfolioLayout.proseWidth,
                                ),
                                child: Text(
                                  achievement,
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
