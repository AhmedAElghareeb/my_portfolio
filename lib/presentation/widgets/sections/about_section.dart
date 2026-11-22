import 'package:flutter/material.dart';

import '../../../core/utils/responsive_helper.dart';
import '../common/glass_card.dart';
import '../common/portfolio_ui.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SectionFrame(
      lighting: const Alignment(.72, -.15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeading(title: 'About'),
          LayoutBuilder(
            builder: (context, constraints) {
              final about = Align(
                alignment: Alignment.topLeft,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: PortfolioLayout.proseWidth,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'I develop Flutter and Dart apps for Android and iOS. At Geexar and in freelance work, I’ve taken apps from requirements and architecture through API integration and release on Google Play and the App Store.',
                        style: theme.textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'I use Clean and Modular Architecture to keep features maintainable as products grow. I collaborate through code reviews and agile planning, and I mentor junior mobile developers.',
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              );
              const education = Reveal(child: _EducationCard());
              if (constraints.maxWidth >= PortfolioLayout.split) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 6, child: about),
                    const SizedBox(width: 48),
                    const Expanded(flex: 4, child: education),
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [about, const SizedBox(height: 24), education],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _EducationCard extends StatelessWidget {
  const _EducationCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Label('EDUCATION  ·  2017–2022'),
          const SizedBox(height: 10),
          WordFitText(
            'Bachelor of Communications and Electronics Engineering',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Nile Higher Institute for Engineering and Technology',
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: 12),
          Text(
            'Graduation project (A+): biometric lock system with fingerprint and facial recognition.',
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
