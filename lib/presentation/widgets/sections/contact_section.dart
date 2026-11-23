import 'package:flutter/material.dart';

import '../../../core/utils/responsive_helper.dart';
import '../../../data/portfolio_data.dart';
import '../common/glass_card.dart';
import '../common/portfolio_ui.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionFrame(
      lighting: const Alignment(.6, -.25),
      child: GlassCard(
        padding: EdgeInsets.all(
          MediaQuery.sizeOf(context).width < PortfolioLayout.compact ? 20 : 36,
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeading(
              title: 'Get in touch',
              description:
                  'For Flutter roles, mobile product work, or engineering collaboration, send me an email.',
            ),
            Reveal(
              order: 1,
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  PortfolioLink(
                    label: 'Email Ahmed',
                    url: 'mailto:${PortfolioData.email}',
                  ),
                  PortfolioLink(label: 'LinkedIn', url: PortfolioData.linkedin),
                  PortfolioLink(label: 'GitHub', url: PortfolioData.github),
                ],
              ),
            ),
            SizedBox(height: 16),
            SelectableText(PortfolioData.email),
          ],
        ),
      ),
    );
  }
}

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final gutter = PortfolioLayout.gutter(MediaQuery.sizeOf(context).width);
    return SectionFrame(
      padding: EdgeInsets.fromLTRB(gutter, 0, gutter, 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          const SizedBox(height: 14),
          Text(
            'Ahmed Ashraf Elghareeb  ·  Flutter / Mobile Developer',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
