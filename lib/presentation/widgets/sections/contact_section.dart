import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../../data/portfolio_data.dart';
import '../common/gradient_button.dart';
import '../common/social_button.dart';

import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final email = _emailController.text;
      final subject = _subjectController.text;
      final message = _messageController.text;

      final emailUri = Uri(
        scheme: 'mailto',
        path: PortfolioData.contactInfo.email,
        query:
            'subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent("Name: $name\nEmail: $email\n\n$message")}',
      );

      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Could not open email client'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = ResponsiveHelper.isDesktop(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Text(
                PortfolioData.contactInfo.title,
                style: theme.textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 60),
              if (isDesktop)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildContactInfo(context)),
                    const SizedBox(width: 60),
                    Expanded(child: _buildContactForm(context)),
                  ],
                )
              else
                Column(
                  children: [
                    _buildContactInfo(context),
                    const SizedBox(height: 60),
                    _buildContactForm(context),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          PortfolioData.contactInfo.subtitle,
          style: theme.textTheme.headlineSmall,
        ),
        const SizedBox(height: 24),
        _buildInfoRow(
          Icons.email,
          PortfolioData.contactInfo.email,
        ),
        _buildInfoRow(
          Icons.phone,
          PortfolioData.contactInfo.phone,
        ),
        _buildInfoRow(
          Icons.location_on,
          PortfolioData.contactInfo.location,
        ),
        const SizedBox(height: 48),
        const Text(
          'Connect with me',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
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
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primaryColor),
          ),
          const SizedBox(width: 16),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildTextField(
            'Name',
            controller: _nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildTextField(
            'Email',
            controller: _emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildTextField(
            'Subject',
            controller: _subjectController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a subject';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildTextField(
            'Message',
            maxLines: 5,
            controller: _messageController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your message';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          GradientButton(
            text: 'Send Message',
            icon: Icons.send,
            width: double.infinity,
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label, {
    int maxLines = 1,
    required TextEditingController controller,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        alignLabelWithHint: true,
      ),
    );
  }
}

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.black26
            : Colors.grey.shade100,
      ),
      child: const Column(
        children: [
          Text(
            '© 2026 Ahmed Ashraf Elghareeb\nAll rights reserved',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
