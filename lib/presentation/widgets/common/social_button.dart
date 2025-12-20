import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';

class SocialButton extends StatelessWidget {
  final IconData icon;
  final String url;
  final Color? color;

  const SocialButton({
    super.key,
    required this.icon,
    required this.url,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: IconButton(
        onPressed: () async {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          }
        },
        icon: FaIcon(icon, size: 24),
        style: IconButton.styleFrom(
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? AppColors.darkSurface
              : AppColors.lightSurface,
          foregroundColor: color ?? AppColors.primaryColor,
          padding: const EdgeInsets.all(12),
          shape: const CircleBorder(),
          elevation: 4,
          shadowColor: Colors.black26,
        ),
      ),
    );
  }
}
