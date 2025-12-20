import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../../data/models/portfolio_models.dart';
import '../../../data/portfolio_data.dart';
import '../common/glass_card.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 80,
        horizontal: isMobile ? 16 : 24,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Section Header
              _buildSectionHeader(theme),
              const SizedBox(height: 60),
              // Timeline
              _buildTimeline(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(ThemeData theme) {
    return Column(
      children: [
        Text(
          'Experience',
          style: theme.textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'My professional journey',
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
      ],
    );
  }

  Widget _buildTimeline(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: PortfolioData.experiences.length,
      separatorBuilder: (context, index) => const SizedBox(height: 0),
      itemBuilder: (context, index) {
        final exp = PortfolioData.experiences[index];
        return _ExperienceTimelineTile(
          experience: exp,
          isFirst: index == 0,
          isLast: index == PortfolioData.experiences.length - 1,
          index: index,
        );
      },
    );
  }
}

class _ExperienceTimelineTile extends StatefulWidget {
  final Experience experience;
  final bool isFirst;
  final bool isLast;
  final int index;

  const _ExperienceTimelineTile({
    required this.experience,
    required this.isFirst,
    required this.isLast,
    required this.index,
  });

  @override
  State<_ExperienceTimelineTile> createState() => _ExperienceTimelineTileState();
}

class _ExperienceTimelineTileState extends State<_ExperienceTimelineTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = ResponsiveHelper.isMobile(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.only(bottom: 32),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline Indicator
            _buildTimelineIndicator(),
            SizedBox(width: isMobile ? 12 : 20),
            // Content Card
            Expanded(
              child: _buildContentCard(theme, isMobile),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineIndicator() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Animated Dot
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: _isHovered ? 24 : 20,
          height: _isHovered ? 24 : 20,
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.primaryColor : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primaryColor,
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor.withOpacity(_isHovered ? 0.5 : 0.2),
                blurRadius: _isHovered ? 15 : 8,
                spreadRadius: _isHovered ? 3 : 1,
              ),
            ],
          ),
          child: _isHovered
              ? const Icon(
                  Icons.work,
                  size: 12,
                  color: Colors.white,
                )
              : null,
        ),
        // Connecting Line
        if (!widget.isLast)
          Container(
            width: 2,
            height: 120,
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.primaryColor,
                  AppColors.primaryColor.withOpacity(0.2),
                ],
              ),
              borderRadius: BorderRadius.circular(1),
            ),
          ),
      ],
    );
  }

  Widget _buildContentCard(ThemeData theme, bool isMobile) {
    final exp = widget.experience;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      transform: Matrix4.identity()..scale(_isHovered ? 1.02 : 1.0),
      child: GlassCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            _buildHeader(theme, exp, isMobile),
            const SizedBox(height: 12),
            
            // Company Info
            _buildCompanyInfo(theme, exp),
            const SizedBox(height: 16),
            
            // Description
            _buildDescription(theme, exp),
            const SizedBox(height: 16),
            
            // Technologies
            _buildTechnologies(exp),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, Experience exp, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                exp.role,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile ? 18 : 22,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primaryColor.withOpacity(0.2),
                AppColors.accentColor.withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.primaryColor.withOpacity(0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.calendar_today,
                size: 14,
                color: AppColors.primaryColor,
              ),
              const SizedBox(width: 6),
              Text(
                exp.period,
                style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompanyInfo(ThemeData theme, Experience exp) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.accentColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.business,
            size: 18,
            color: AppColors.accentColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                exp.company,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.accentColor,
                ),
              ),
              Text(
                exp.location,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(ThemeData theme, Experience exp) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: exp.description.map((desc) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: const Icon(
                  Icons.check_circle,
                  size: 16,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  desc,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    height: 1.6,
                    color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTechnologies(Experience exp) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: exp.technologies.map((tech) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primaryColor.withOpacity(0.15),
                AppColors.accentColor.withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.primaryColor.withOpacity(0.2),
            ),
          ),
          child: Text(
            tech,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
            ),
          ),
        );
      }).toList(),
    );
  }
}