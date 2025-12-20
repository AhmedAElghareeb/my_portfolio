import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../../data/models/portfolio_models.dart';
import '../../../data/portfolio_data.dart';
import '../common/glass_card.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  String _selectedCategory = 'All';
  final List<String> _categories = [
    'All',
    'Fintech',
    'Transportation',
    'E-commerce',
  ];

  List<Project> get _filteredProjects {
    if (_selectedCategory == 'All') return PortfolioData.projects;
    return PortfolioData.projects
        .where((p) => p.category == _selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = ResponsiveHelper.isDesktop(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Text(
                'Projects',
                style: theme.textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Some of my recent work',
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
              const SizedBox(height: 48),

              // Filter Chips
              Wrap(
                spacing: 12,
                children: _categories.map((category) {
                  final isSelected = _selectedCategory == category;
                  return ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _selectedCategory = category);
                      }
                    },
                    selectedColor: AppColors.accentColor,
                    labelStyle: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : theme.textTheme.bodyMedium?.color,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 48),

              // Projects Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isDesktop
                      ? 3
                      : (ResponsiveHelper.isTablet(context) ? 2 : 1),
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                ),
                itemCount: _filteredProjects.length,
                itemBuilder: (context, index) {
                  final project = _filteredProjects[index];
                  return _buildProjectCard(context, project)
                      .animate()
                      .fadeIn(delay: (index * 100).ms)
                      .slideY(begin: 0.1, end: 0);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, Project project) {
    final theme = Theme.of(context);
    return GlassCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Project Image Placeholder
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.grey.shade200, // Placeholder
              child: project.image != null
                  ? Center(
                      child: Image.network(
                        project
                            .image!, // In real deploy use generic placeholder if asset missing
                        fit: BoxFit.cover,
                        errorBuilder: (c, e, s) => const Center(
                          child:
                              Icon(Icons.image, size: 50, color: Colors.grey),
                        ),
                      ),
                    )
                  : const Center(
                      child: Icon(Icons.image, size: 50, color: Colors.grey),
                    ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          project.category,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (project.featured)
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    project.title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    project.subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.accentColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    project.description,
                    style: theme.textTheme.bodyMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  // Technologies
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: project.technologies
                        .take(3)
                        .map(
                          (t) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.3),
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              t,
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          final uri = Uri.parse(project.playStoreUrl ?? '');
                          await launchUrl(uri);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
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
                          child: const Text(
                            'Google Play',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      if (project.appStoreUrl != null)
                        const SizedBox(width: 16),
                      if (project.appStoreUrl != null)
                        InkWell(
                          onTap: () async {
                            final uri = Uri.parse(project.appStoreUrl ?? '');
                            await launchUrl(uri);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
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
                            child: const Text(
                              'App Store',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                    ],
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
