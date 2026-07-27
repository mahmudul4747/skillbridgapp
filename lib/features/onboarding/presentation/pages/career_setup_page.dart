import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
class CareerSetupPage
    extends ConsumerStatefulWidget {
  const CareerSetupPage({super.key});

  @override
  ConsumerState<CareerSetupPage> createState() =>
      _CareerSetupPageState();
}

class _CareerSetupPageState
    extends ConsumerState<CareerSetupPage> {
  String? selectedCareer;
  String? selectedLevel;

  final List<String> careers = [
    'Flutter Developer',
    'Android Developer',
    'Web Developer',
    'Backend Developer',
    'UI/UX Designer',
    'Data Analyst',
    'AI/ML Engineer',
  ];

  final List<String> levels = [
    'Student',
    'Fresher',
    'Junior',
    'Mid-Level',
  ];

  void _continue() {
    if (selectedCareer == null ||
        selectedLevel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please select your career goal and experience level',
          ),
        ),
      );

      return;
    }

    context.go('/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),

              const Text(
                'Let’s Personalize Your Journey 🎯',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkText,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'Tell us about your career goal so we can create a personalized roadmap for you.',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: AppTheme.grayText,
                ),
              ),

              const SizedBox(height: 35),

              const Text(
                'What is your career goal?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkText,
                ),
              ),

              const SizedBox(height: 16),

              ...careers.map(
                (career) {
                  final selected =
                      selectedCareer == career;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCareer = career;
                      });
                    },
                    child: AnimatedContainer(
                      duration:
                          const Duration(milliseconds: 250),
                      margin:
                          const EdgeInsets.only(bottom: 12),
                      padding:
                          const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: selected
                            ? AppTheme.primaryBlue
                                .withValues(alpha: 0.08)
                            : Colors.white,
                        borderRadius:
                            BorderRadius.circular(16),
                        border: Border.all(
                          color: selected
                              ? AppTheme.primaryBlue
                              : Colors.grey.shade200,
                          width: selected ? 1.5 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            selected
                                ? Icons
                                    .radio_button_checked
                                : Icons
                                    .radio_button_off,
                            color: selected
                                ? AppTheme.primaryBlue
                                : AppTheme.grayText,
                          ),
                          const SizedBox(width: 14),
                          Text(
                            career,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: selected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color:
                                  AppTheme.darkText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              const Text(
                'What is your experience level?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkText,
                ),
              ),

              const SizedBox(height: 16),

              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: levels.map(
                  (level) {
                    final selected =
                        selectedLevel == level;

                    return ChoiceChip(
                      label: Text(level),
                      selected: selected,
                      onSelected: (_) {
                        setState(() {
                          selectedLevel = level;
                        });
                      },
                    );
                  },
                ).toList(),
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: _continue,
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}