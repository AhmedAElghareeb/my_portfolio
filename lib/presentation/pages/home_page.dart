import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/responsive_helper.dart';
import '../widgets/common/glass_card.dart';
import '../widgets/common/portfolio_ui.dart';
import '../widgets/sections/about_section.dart';
import '../widgets/sections/contact_section.dart';
import '../widgets/sections/experience_section.dart';
import '../widgets/sections/hero_section.dart';
import '../widgets/sections/projects_section.dart';
import '../widgets/sections/skills_section.dart';

enum _Section {
  home('Home'),
  work('Work'),
  projects('Projects'),
  experience('Experience'),
  expertise('Expertise'),
  about('About'),
  contact('Contact');

  const _Section(this.label);

  final String label;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  final _anchors = {
    for (final section in _Section.values) section: GlobalKey(),
  };
  final _focusNodes = {
    for (final section in _Section.values)
      section: FocusNode(debugLabel: section.label, skipTraversal: true),
  };

  @override
  void dispose() {
    _scrollController.dispose();
    for (final focus in _focusNodes.values) {
      focus.dispose();
    }
    super.dispose();
  }

  void _navigate(_Section section) {
    final target = _anchors[section]?.currentContext;
    if (target == null) return;
    _focusNodes[section]?.requestFocus();
    Scrollable.ensureVisible(
      target,
      duration: MediaQuery.disableAnimationsOf(context)
          ? Duration.zero
          : PortfolioLayout.scroll,
      curve: PortfolioLayout.ease,
    );
  }

  Widget _anchor(_Section section, Widget child) => Focus(
    key: _anchors[section],
    focusNode: _focusNodes[section],
    child: child,
  );

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final scaledNavText = MediaQuery.textScalerOf(context).scale(14) / 14;
    final desktopNav =
        width >= PortfolioLayout.navigation + (scaledNavText - 1) * 460;
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(desktopNav),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _anchor(
                      _Section.home,
                      HeroSection(
                        onExplore: () => _navigate(_Section.work),
                        onContact: () => _navigate(_Section.contact),
                      ),
                    ),
                    _anchor(_Section.work, const FeaturedProjectsSection()),
                    _anchor(_Section.projects, const ProjectsSection()),
                    ColoredBox(
                      color: Color.lerp(
                        theme.scaffoldBackgroundColor,
                        theme.colorScheme.surface,
                        .62,
                      )!,
                      child: _anchor(
                        _Section.experience,
                        const ExperienceSection(),
                      ),
                    ),
                    _anchor(_Section.expertise, const SkillsSection()),
                    _anchor(_Section.about, const AboutSection()),
                    _anchor(_Section.contact, const ContactSection()),
                    const FooterSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(bool desktopNav) {
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final compactBrand = width < PortfolioLayout.minFullWidth;
    // Use the current surface during the theme tween so the labels stay legible
    // in the same frame as the glass background.
    final foreground = theme.colorScheme.surface.computeLuminance() < .18
        ? AppColors.darkText
        : AppColors.lightText;
    return GlassAtmosphere(
      alignment: const Alignment(.7, -1),
      child: GlassCard(
        radius: 0,
        padding: EdgeInsets.zero,
        interactive: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: PortfolioLayout.gutter(width),
            vertical: 8,
          ),
          child: ContentWidth(
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: TextButton(
                      onPressed: () => _navigate(_Section.home),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                      ),
                      child: WordFitText(
                        compactBrand ? 'AE' : 'Ahmed Elghareeb',
                        compactText: 'AE',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: foreground,
                        ),
                      ),
                    ),
                  ),
                ),
                if (desktopNav)
                  for (final section in _Section.values.skip(1))
                    TextButton(
                      onPressed: () => _navigate(section),
                      child: Text(
                        section.label,
                        style: TextStyle(color: foreground),
                      ),
                    ),
                PortfolioThemeButton(color: foreground),
                if (!desktopNav)
                  IconButton(
                    constraints: const BoxConstraints(
                      minWidth: 48,
                      minHeight: 48,
                    ),
                    tooltip: 'Open navigation',
                    color: foreground,
                    icon: const Icon(Icons.menu),
                    onPressed: _openNavigation,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openNavigation() async {
    final reduce = MediaQuery.disableAnimationsOf(context);
    final offset = Directionality.of(context) == TextDirection.ltr ? 1.0 : -1.0;
    final route = RawDialogRoute<_Section>(
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: reduce ? Duration.zero : PortfolioLayout.filter,
      pageBuilder: (context, _, _) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: _buildDrawer(context),
      ),
      transitionBuilder: (context, animation, _, child) => SlideTransition(
        position: animation.drive(
          Tween(
            begin: Offset(offset, 0),
            end: Offset.zero,
          ).chain(CurveTween(curve: PortfolioLayout.ease)),
        ),
        child: child,
      ),
    );
    final selected = await Navigator.of(context).push(route);
    await route.completed;
    if (mounted && selected != null) _navigate(selected);
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(
        context,
      ).colorScheme.surface.withValues(alpha: .94),
      surfaceTintColor: Colors.transparent,
      child: GlassCard(
        padding: EdgeInsets.zero,
        interactive: false,
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: IconButton(
                  constraints: const BoxConstraints(
                    minWidth: 48,
                    minHeight: 48,
                  ),
                  tooltip: 'Close navigation',
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ),
              for (final section in _Section.values)
                ListTile(
                  title: WordFitText(section.label),
                  onTap: () => Navigator.of(context).pop(section),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
