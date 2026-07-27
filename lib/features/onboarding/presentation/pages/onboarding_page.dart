import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();

  int _currentPage = 0;

  final List<OnboardingData> _pages = [
    const OnboardingData(
      image: 'assets/images/slider11.png',
    ),
    const OnboardingData(
      image: 'assets/images/slider12.png',
    ),
    const OnboardingData(
      image: 'assets/images/slider13.png',
    ),
    const OnboardingData(
      image: 'assets/images/slider14.png',
    ),
    const OnboardingData(
      image: 'assets/images/slider15.png',
    ),

  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      context.go('/login');
    }
  }

  void _skip() {
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _skip,
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: AppTheme.grayText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            // Onboarding Images
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final page = _pages[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    child: Image.asset(
                      page.image,
                      fit: BoxFit.contain,
                      errorBuilder: (
                        context,
                        error,
                        stackTrace,
                      ) {
                        return Container(
                          decoration: BoxDecoration(
                            color: AppTheme.primaryBlue.withValues(
                              alpha: 0.08,
                            ),
                            borderRadius:
                                BorderRadius.circular(32),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.image_outlined,
                              size: 80,
                              color: AppTheme.primaryBlue,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),

            // Bottom Section
            Padding(
              padding: const EdgeInsets.fromLTRB(
                24,
                10,
                24,
                24,
              ),
              child: Row(
                children: [
                  // Page Indicator
                  Expanded(
                    child: Row(
                      children: List.generate(
                        _pages.length,
                        (index) {
                          final isActive =
                              index == _currentPage;

                          return AnimatedContainer(
                            duration: const Duration(
                              milliseconds: 300,
                            ),
                            margin: const EdgeInsets.only(
                              right: 6,
                            ),
                            height: 8,
                            width: isActive ? 28 : 8,
                            decoration: BoxDecoration(
                              color: isActive
                                  ? AppTheme.primaryBlue
                                  : Colors.grey.shade300,
                              borderRadius:
                                  BorderRadius.circular(20),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // Next Button
                  GestureDetector(
                    onTap: _nextPage,
                    child: AnimatedContainer(
                      duration: const Duration(
                        milliseconds: 300,
                      ),
                      height: 58,
                      width: 58,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [
                            AppTheme.primaryBlue,
                            AppTheme.secondaryPurple,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primaryBlue
                                .withValues(alpha: 0.25),
                            blurRadius: 15,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Icon(
                        _currentPage ==
                                _pages.length - 1
                            ? Icons.check_rounded
                            : Icons.arrow_forward_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingData {
  final String image;

  const OnboardingData({
    required this.image,
  });
}