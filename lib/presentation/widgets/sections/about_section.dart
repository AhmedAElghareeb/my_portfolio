import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../../data/portfolio_data.dart';
import '../common/glass_card.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'About Me',
                style: theme.textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                PortfolioData.aboutSection['subtitle'] as String,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 60),
              if (isDesktop)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildDescription(theme)),
                    const SizedBox(width: 60),
                    Expanded(child: _buildStatsGrid()),
                  ],
                )
              else
                Column(
                  children: [
                    _buildDescription(theme),
                    const SizedBox(height: 48),
                    _buildStatsGrid(),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDescription(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          PortfolioData.aboutSection['description'] as String,
          style: theme.textTheme.bodyLarge?.copyWith(height: 1.8, fontSize: 16),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 30),

        // Fun Facts
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: (PortfolioData.aboutSection['funFacts'] as List)
              .map(
                (fact) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.primaryColor.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    fact,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildStatsGrid() {
    final highlights = PortfolioData.aboutSection['highlights'] as List;

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.4,
      ),
      itemCount: highlights.length,
      itemBuilder: (context, index) {
        final item = highlights[index] as Map<String, dynamic>;
        IconData? icon;
        switch (item['icon']) {
          case 'rocket':
            icon = Icons.rocket_launch;
            break;
          case 'code':
            icon = Icons.code;
            break;
          case 'mobile':
            icon = Icons.smartphone;
            break;
          case 'team':
            icon = Icons.groups;
            break;
          default:
            icon = Icons.star;
        }

        return GlassCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: AppColors.accentColor),
              const SizedBox(height: 12),
              Expanded(
                child: Text(
                  item['title'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 4),
              Expanded(
                child: Text(
                  item['desc'],
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
