import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/utils/responsive_helper.dart';
import '../../../data/models/portfolio_models.dart';
import '../../../data/portfolio_data.dart';
import '../common/glass_card.dart';
import '../common/portfolio_ui.dart';

class FeaturedProjectsSection extends StatelessWidget {
  const FeaturedProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    const projects = PortfolioData.featured;
    return SectionFrame(
      lighting: const Alignment(-.38, -.86),
      etched: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeading(
            title: 'Featured work',
            description:
                'Selected cross-platform apps and the engineering behind them.',
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < PortfolioLayout.split) {
                return ResponsiveCards(
                  maxColumns: 2,
                  children: [
                    for (final (index, project) in projects.indexed)
                      Reveal(
                        order: index % 2,
                        child: _ProjectCard(project: project, featured: true),
                      ),
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BackdropGroup(
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 7,
                          child: Reveal(
                            child: _ProjectCard(
                              project: PortfolioData.zidcash,
                              featured: true,
                              frosted: true,
                            ),
                          ),
                        ),
                        SizedBox(width: PortfolioLayout.gap),
                        Expanded(
                          flex: 5,
                          child: Reveal(
                            order: 1,
                            child: _ProjectCard(
                              project: PortfolioData.ufoo,
                              featured: true,
                              frosted: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: PortfolioLayout.gap),
                  ResponsiveCards(
                    maxColumns: 2,
                    children: [
                      for (final (index, project) in projects.skip(2).indexed)
                        Reveal(
                          order: index % 2,
                          child: _ProjectCard(project: project, featured: true),
                        ),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  static const _categories = [
    'All',
    'Education',
    'Fintech',
    'Logistics',
    'Ride-Hailing',
    'Transportation',
    'E-commerce',
    'Utilities',
  ];
  String _category = 'All';

  @override
  Widget build(BuildContext context) {
    final projects = _category == 'All'
        ? PortfolioData.projects
        : PortfolioData.projects
              .where((project) => project.category == _category)
              .toList();
    return SectionFrame(
      lighting: const Alignment(.62, -.86),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeading(
            title: 'All projects',
            description: 'Browse the complete portfolio by industry.',
          ),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: [
              for (final category in _categories)
                ChoiceChip(
                  label: Text(category),
                  selected: category == _category,
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  onSelected: (selected) {
                    if (selected) setState(() => _category = category);
                  },
                ),
            ],
          ),
          const SizedBox(height: 16),
          Semantics(
            liveRegion: true,
            child: Text(
              '${projects.length} ${projects.length == 1 ? 'project' : 'projects'}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 16),
          ResponsiveCards(
            children: [
              for (final (index, project) in projects.indexed)
                Reveal(
                  key: ValueKey(project.title),
                  duration: PortfolioLayout.filter,
                  order: index % 3,
                  travel: 8,
                  child: _ProjectCard(project: project),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({
    required this.project,
    this.featured = false,
    this.frosted = false,
  });

  final Project project;
  final bool featured;
  final bool frosted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GlassCard(
      padding: EdgeInsets.zero,
      frosted: frosted,
      lift: featured,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (featured)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(PortfolioLayout.radius - 1),
              ),
              child: _ProjectGallery(project: project),
            ),
          Padding(
            padding: EdgeInsets.all(featured ? 24 : 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Label(project.category.toUpperCase()),
                const SizedBox(height: 8),
                Semantics(
                  container: true,
                  header: true,
                  headingLevel: 3,
                  child: WordFitText(
                    project.title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontSize: featured ? 29 : 23,
                      letterSpacing: -.4,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(project.description, style: theme.textTheme.bodyLarge),
                if (featured && project.contribution != null) ...[
                  const SizedBox(height: 14),
                  Text('My contribution', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    project.contribution!,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
                const SizedBox(height: 15),
                TagList(project.technologies),
                if (project.links.isNotEmpty ||
                    project.features.isNotEmpty) ...[
                  const SizedBox(height: 17),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final link in project.links)
                        PortfolioLink(label: link.label, url: link.url),
                      if (project.features.isNotEmpty)
                        TextButton(
                          onPressed: () => _showProject(context, project),
                          child: Text(
                            featured ? 'Case study' : 'Project details',
                          ),
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectGallery extends StatefulWidget {
  const _ProjectGallery({required this.project});

  final Project project;

  @override
  State<_ProjectGallery> createState() => _ProjectGalleryState();
}

class _ProjectGalleryState extends State<_ProjectGallery> {
  final _visibilityKey = UniqueKey();
  bool _visible = false;
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final reduced = MediaQuery.disableAnimationsOf(context);
    final project = widget.project;
    final images = project.screenshots.isNotEmpty
        ? project.screenshots
        : [if (project.image case final image?) image];

    if (images.isEmpty) return const SizedBox.shrink();
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: VisibilityDetector(
        key: _visibilityKey,
        onVisibilityChanged: _visible
            ? null
            : (info) {
                if (mounted && !_visible && info.visibleFraction > 0) {
                  setState(() => _visible = true);
                }
              },
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                colors.surfaceContainerHighest.withValues(alpha: .56),
                colors.surface.withValues(alpha: .32),
              ],
            ),
            border: Border(bottom: BorderSide(color: colors.outline)),
          ),
          child: !_visible
              ? null
              : MouseRegion(
                  onEnter: (_) => setState(() => _hovered = true),
                  onExit: (_) => setState(() => _hovered = false),
                  child: AnimatedScale(
                    scale: !reduced && _hovered ? 1.025 : 1,
                    duration: reduced ? Duration.zero : PortfolioLayout.filter,
                    curve: PortfolioLayout.ease,
                    child: RepaintBoundary(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (final (index, path) in images.indexed) ...[
                              if (index > 0) const SizedBox(width: 12),
                              Flexible(
                                child: Image.asset(
                                  path,
                                  fit: BoxFit.contain,
                                  frameBuilder:
                                      (context, child, frame, synchronous) {
                                        if (reduced || synchronous)
                                          return child;
                                        return AnimatedOpacity(
                                          opacity: frame == null ? 0 : 1,
                                          duration: PortfolioLayout.fast,
                                          curve: PortfolioLayout.ease,
                                          child: child,
                                        );
                                      },
                                  semanticLabel: project.screenshots.isEmpty
                                      ? '${project.title} logo'
                                      : '${project.title} app screenshot ${index + 1}',
                                  errorBuilder: (context, error, stack) =>
                                      const SizedBox.shrink(),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

void _showProject(BuildContext context, Project project) {
  showDialog<void>(
    context: context,
    animationStyle: MediaQuery.disableAnimationsOf(context)
        ? AnimationStyle.noAnimation
        : null,
    builder: (context) {
      final theme = Theme.of(context);
      return AlertDialog(
        scrollable: true,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
        title: Text(project.title),
        content: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(project.description, style: theme.textTheme.bodyLarge),
              const SizedBox(height: 16),
              Text('How it works', style: theme.textTheme.titleMedium),
              for (final feature in project.features)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text('•  $feature', style: theme.textTheme.bodyMedium),
                ),
              if (project.contribution case final contribution?) ...[
                const SizedBox(height: 16),
                Text('My contribution', style: theme.textTheme.titleMedium),
                const SizedBox(height: 6),
                Text(contribution, style: theme.textTheme.bodyMedium),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}
