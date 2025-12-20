import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../core/theme/theme_cubit.dart';
import '../../core/utils/responsive_helper.dart';
import '../widgets/sections/about_section.dart';
import '../widgets/sections/contact_section.dart';
import '../widgets/sections/experience_section.dart';
import '../widgets/sections/hero_section.dart';
import '../widgets/sections/projects_section.dart';
import '../widgets/sections/skills_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  // Keys for scrolling
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    if (key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: isDesktop
          ? _buildDesktopAppBar(context)
          : _buildMobileAppBar(context),
      drawer: !isDesktop ? _buildMobileDrawer(context) : null,
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              HeroSection(key: _heroKey),
              AboutSection(key: _aboutKey),
              ExperienceSection(key: _experienceKey),
              const SkillsSection(),
              ProjectsSection(key: _projectsKey),
              ContactSection(key: _contactKey),
              if (isDesktop) const FooterSection(),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildDesktopAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      title: const Padding(
        padding: EdgeInsets.only(left: 32),
        child: Text(
          'Ahmed Elghareeb',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            letterSpacing: 1.5,
          ),
        ),
      ),
      actions: [
        _NavBarItem(title: 'Home', onTap: () => _scrollToSection(_heroKey)),
        _NavBarItem(title: 'About', onTap: () => _scrollToSection(_aboutKey)),
        _NavBarItem(
          title: 'Experience',
          onTap: () => _scrollToSection(_experienceKey),
        ),
        _NavBarItem(
          title: 'Projects',
          onTap: () => _scrollToSection(_projectsKey),
        ),
        _NavBarItem(
          title: 'Contact',
          onTap: () => _scrollToSection(_contactKey),
        ),

        const SizedBox(width: 16),
        // Theme Toggle
        BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, mode) {
            return IconButton(
              icon: Icon(
                mode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
              ),
              onPressed: () => context.read<ThemeCubit>().toggleTheme(),
            );
          },
        ),
        const SizedBox(width: 32),
      ],
    );
  }

  PreferredSizeWidget _buildMobileAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Text(
        'Ahmed Elghareeb',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: [
        BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, mode) {
            return IconButton(
              icon: Icon(
                mode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
              ),
              onPressed: () => context.read<ThemeCubit>().toggleTheme(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildMobileDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.gradientStart, AppColors.gradientEnd],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Quick Actions...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.pop(context);
                    _scrollToSection(_heroKey);
                  },
                ),
                ListTile(
                  title: const Text('About'),
                  onTap: () {
                    Navigator.pop(context);
                    _scrollToSection(_aboutKey);
                  },
                ),
                ListTile(
                  title: const Text('Experience'),
                  onTap: () {
                    Navigator.pop(context);
                    _scrollToSection(_experienceKey);
                  },
                ),
                ListTile(
                  title: const Text('Projects'),
                  onTap: () {
                    Navigator.pop(context);
                    _scrollToSection(_projectsKey);
                  },
                ),
                ListTile(
                  title: const Text('Contact'),
                  onTap: () {
                    Navigator.pop(context);
                    _scrollToSection(_contactKey);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 7),
          const FooterSection(),
          const SizedBox(height: 7),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _NavBarItem({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextButton(
        onPressed: onTap,
        child: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
