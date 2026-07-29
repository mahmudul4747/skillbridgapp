import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class SkillsPage extends StatelessWidget {
  const SkillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xffF7F8FC),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'My Skills',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppTheme.darkText,
          ),
        ),
      ),

      body: ListView(
        padding:
            const EdgeInsets.all(20),
        children: [
          const Text(
            'Your Skill Progress',
            style: TextStyle(
              fontSize: 20,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          _SkillCard(
            name: 'Dart',
            progress: 0.85,
          ),

          _SkillCard(
            name: 'Flutter',
            progress: 0.70,
          ),

          _SkillCard(
            name: 'Firebase',
            progress: 0.55,
          ),

          _SkillCard(
            name: 'Git & GitHub',
            progress: 0.65,
          ),
        ],
      ),
    );
  }
}

class _SkillCard
    extends StatelessWidget {
  final String name;
  final double progress;

  const _SkillCard({
    required this.name,
    required this.progress,
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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,
            children: [
              Text(
                name,
                style:
                    const TextStyle(
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              Text(
                '${(progress * 100).toInt()}%',
                style:
                    const TextStyle(
                  color:
                      AppTheme.primaryBlue,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          LinearProgressIndicator(
            value: progress,
            minHeight: 7,
            borderRadius:
                BorderRadius.circular(
                    10),
          ),
        ],
      ),
    );
  }
}