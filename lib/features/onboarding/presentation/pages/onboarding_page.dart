import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),

              Container(
                height: 220,
                width: 220,
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue.withValues(
                    alpha: 0.1,
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.rocket_launch_rounded,
                  size: 100,
                  color: AppTheme.primaryBlue,
                ),
              ),

              const SizedBox(height: 50),

              const Text(
                'Build Your Career',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkText,
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                'Build skills, create your professional resume, '
                'practice interviews and find your dream job '
                'with SkillBridge.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.6,
                  color: AppTheme.grayText,
                ),
              ),

              const Spacer(),

              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              TextButton(
                onPressed: () {},
                child: const Text('Skip'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}