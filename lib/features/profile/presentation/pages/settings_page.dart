import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../shared/providers/theme_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'App Preferences',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.grayText),
            ),
            const SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  SwitchListTile(
                    secondary: Icon(
                      isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                      color: AppTheme.primaryBlue,
                    ),
                    title: const Text('Dark Mode', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text('Toggle between dark and light themes'),
                    value: isDarkMode,
                    onChanged: (val) {
                      ref.read(themeModeProvider.notifier).setThemeMode(
                            val ? ThemeMode.dark : ThemeMode.light,
                          );
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.language_rounded, color: AppTheme.primaryBlue),
                    title: const Text('Language', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text('English (United States)'),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Language selection: English selected')),
                      );
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.notifications_active_rounded, color: AppTheme.primaryBlue),
                    title: const Text('Push Notifications', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text('Receive job alerts & application status updates'),
                    trailing: Switch(
                      value: true,
                      onChanged: (val) {},
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Account & Security',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.grayText),
            ),
            const SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ListTile(
                leading: const Icon(Icons.lock_reset_rounded, color: Colors.orange),
                title: const Text('Reset Password', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('Send password reset email to your registered address'),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                onTap: () => context.push('/forgot-password'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
