import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/portfolio_models.dart';
import '../../../data/portfolio_data.dart';
import '../common/glass_card.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Text(
                'Skills',
                style: theme.textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              Text(
                'My technical expertise',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: 60,
                height: 4,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primaryColor, AppColors.accentColor],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 60),

              // Use Wrap to make it responsive
              Wrap(
                spacing: 24,
                runSpacing: 24,
                alignment: WrapAlignment.center,
                children: PortfolioData.skills
                    .map(
                      (category) => SizedBox(
                        width: 350,
                        child: _buildSkillCategory(context, category),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkillCategory(BuildContext context, SkillCategory category) {
    final theme = Theme.of(context);

    return GlassCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.layers, color: AppColors.accentColor),
              const SizedBox(width: 12),
              Text(
                category.title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Divider(height: 32),
          ...category.skills.map(
            (skill) => Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        skill.name,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '${skill.level.toInt()}%',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: skill.level / 100,
                    backgroundColor: Colors.grey.withOpacity(0.2),
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(4),
                    minHeight: 6,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
