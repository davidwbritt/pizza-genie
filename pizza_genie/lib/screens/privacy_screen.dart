import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // Privacy policy content
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Clevermonkey Pizza Genie\nPrivacy Policy',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSection(
                      context,
                      'Information We Collect',
                      'Our Clevermonkey Pizza Genie app is designed to respect your privacy. We collect minimal information:\n\n'
                          '• App Preferences: We store your measurement system preferences (metric/imperial) and theme choices locally on your device\n'
                          '• No Personal Data: We do not collect names, email addresses, or personal information\n'
                          '• No Recipe History: Your pizza recipes and calculations are not stored or transmitted anywhere'),
                  _buildSection(
                      context,
                      'How We Use Information',
                      '• App Settings: Used solely to remember your preferred measurement units and app appearance\n'
                      '• Local Storage Only: All data stays on your device and is never transmitted to external servers'),
                  _buildSection(
                      context,
                      'Information We Don\'t Collect',
                      '• Personal identification information\n'
                          '• Location data\n'
                          '• Contact information\n'
                          '• Pizza recipe calculations or history\n'
                          '• Device identifiers\n'
                          '• Analytics or usage data'),
                  _buildSection(
                      context,
                      'Third-Party Services',
                      '• No Third-Party Analytics: We do not use Google Analytics or similar services\n'
                          '• No Advertising Networks: We do not display ads or use ad networks\n'
                          '• No External Data Sharing: Your pizza recipes and preferences never leave your device'),
                  _buildSection(
                      context,
                      'Data Security',
                      'Since we collect minimal data and store everything locally on your device:\n'
                          '• No data is transmitted over the internet\n'
                          '• No servers store your information\n'
                          '• Your privacy is protected by design'),
                  _buildSection(context, 'Children\'s Privacy',
                      'Our app is suitable for all ages and does not collect personal information from anyone, including children under 13.'),
                  _buildSection(context, 'Contact Us',
                      'If you have questions about this privacy policy, please contact us through the app store.'),
                  const SizedBox(height: 20),
                  Text(
                    'This Clevermonkey Pizza Genie app is created for home pizza enthusiasts and culinary education.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            height: 1.5,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}