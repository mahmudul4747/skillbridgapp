import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class AiPage extends StatelessWidget {
  const AiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xffF7F8FC),

      appBar: AppBar(
        backgroundColor:
            Colors.transparent,
        elevation: 0,
        title: const Text(
          'AI Career Assistant',
          style: TextStyle(
            fontWeight:
                FontWeight.bold,
            color:
                AppTheme.darkText,
          ),
        ),
      ),

      body: ListView(
        padding:
            const EdgeInsets.all(20),
        children: [
          Container(
            padding:
                const EdgeInsets.all(24),
            decoration:
                BoxDecoration(
              gradient:
                  const LinearGradient(
                colors: [
                  AppTheme.primaryBlue,
                  AppTheme.secondaryPurple,
                ],
              ),
              borderRadius:
                  BorderRadius.circular(
                      25),
            ),
            child: const Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons
                      .auto_awesome_rounded,
                  color:
                      Colors.white,
                  size: 40,
                ),

                SizedBox(height: 15),

                Text(
                  'Your AI Career Coach',
                  style:
                      TextStyle(
                    color:
                        Colors.white,
                    fontSize: 24,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  'Get personalized career guidance powered by AI.',
                  style:
                      TextStyle(
                    color:
                        Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          _AiFeature(
            icon:
                Icons.description_outlined,
            title: 'AI CV Analyzer',
            subtitle:
                'Analyze and improve your CV',
          ),

          _AiFeature(
            icon:
                Icons.psychology_outlined,
            title: 'Skill Gap Analyzer',
            subtitle:
                'Find skills you need to learn',
          ),

          _AiFeature(
            icon:
                Icons.record_voice_over_outlined,
            title: 'AI Interview',
            subtitle:
                'Practice real interview questions',
          ),

          _AiFeature(
            icon:
                Icons.route_outlined,
            title: 'Career Roadmap',
            subtitle:
                'Get a personalized learning path',
          ),
        ],
      ),
    );
  }
}

class _AiFeature
    extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _AiFeature({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          const EdgeInsets.only(
        bottom: 14,
      ),
      padding:
          const EdgeInsets.all(18),
      decoration:
          BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            height: 52,
            width: 52,
            decoration:
                BoxDecoration(
              color: AppTheme
                  .primaryBlue
                  .withValues(
                alpha: 0.1,
              ),
              borderRadius:
                  BorderRadius.circular(
                      15),
            ),
            child: Icon(
              icon,
              color:
                  AppTheme.primaryBlue,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:
                      const TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  subtitle,
                  style:
                      const TextStyle(
                    color:
                        AppTheme.grayText,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons
                .arrow_forward_ios_rounded,
            size: 16,
          ),
        ],
      ),
    );
  }
}