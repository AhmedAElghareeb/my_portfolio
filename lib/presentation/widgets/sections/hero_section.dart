import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:particles_flutter/particles_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../../data/portfolio_data.dart';
import '../common/gradient_button.dart';
import '../common/social_button.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = ResponsiveHelper.isDesktop(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SizedBox(
      height: size.height,
      width: double.infinity,
      child: Stack(
        children: [
          // Background Particles
          if (isDark)
            CircularParticle(
              height: size.height,
              width: size.width,
              isRandomColor: false,
              particleColor: AppColors.primaryColor.withOpacity(0.3),
              numberOfParticles: 100,
              speedOfParticles: 1,
              maxParticleSize: 4,
              awayRadius: 100,
              onTapAnimation: true,
              connectDots: true,
            ),

          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Greeting
                  Text(
                    PortfolioData.heroSection['greeting'] as String,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: AppColors.accentColor,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 600.ms)
                      .slideY(begin: -0.2, end: 0),

                  const SizedBox(height: 16),

                  // Name
                  Text(
                    PortfolioData.heroSection['name'] as String,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.displayLarge?.copyWith(
                      fontSize: isDesktop ? 64 : 40,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                    ),
                  ).animate().fadeIn(delay: 200.ms, duration: 600.ms).scale(),

                  const SizedBox(height: 16),

                  // Typewriter Titles
                  SizedBox(
                    height: 50,
                    child: DefaultTextStyle(
                      style: theme.textTheme.headlineSmall!.copyWith(
                        fontSize: isDesktop ? 32 : 20,
                        color: isDark ? Colors.white70 : Colors.black87,
                      ),
                      child: AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts:
                            (PortfolioData.heroSection['titles'] as List)
                                .map(
                                  (title) => TypewriterAnimatedText(
                                    title,
                                    speed: const Duration(milliseconds: 100),
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Buttons
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    alignment: WrapAlignment.center,
                    children: [
                      GradientButton(
                        text: 'Download CV',
                        icon: Icons.download,
                        onPressed: () async {
                          final Uri cvUri = Uri.parse(
                              'https://drive.google.com/file/d/185OsljMAsz4l-8mv_bNhj8omJc1IP4n5/view?usp=sharing');
                          if (await canLaunchUrl(cvUri)) {
                            await launchUrl(cvUri);
                          } else {
                            debugPrint('Could not launch CV url');
                          }
                        },
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          final uri = Uri.parse(
                              PortfolioData.contactInfo.socialLinks.whatsapp);
                          await launchUrl(uri);
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: AppColors.primaryColor,
                            width: 2,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          fixedSize: const Size.fromHeight(47),
                        ),
                        child: Text(
                          'Contact Me',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color:
                                isDark ? Colors.white : AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.2, end: 0),

                  const SizedBox(height: 48),

                  // Social Icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialButton(
                        icon: FontAwesomeIcons.github,
                        url: PortfolioData.contactInfo.socialLinks.github,
                      ),
                      SocialButton(
                        icon: FontAwesomeIcons.linkedin,
                        url: PortfolioData.contactInfo.socialLinks.linkedin,
                      ),
                      SocialButton(
                        icon: FontAwesomeIcons.whatsapp,
                        url: PortfolioData.contactInfo.socialLinks.whatsapp,
                      ),
                    ],
                  ).animate().fadeIn(delay: 800.ms),
                ],
              ),
            ),
          ),

          // Scroll Indicator
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  Text('Scroll Down', style: theme.textTheme.bodySmall),
                  const SizedBox(height: 8),
                  const Icon(Icons.keyboard_arrow_down,
                          color: AppColors.accentColor)
                      .animate(
                        onPlay: (controller) =>
                            controller.repeat(reverse: true),
                      )
                      .moveY(begin: 0, end: 10, duration: 1.seconds),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
