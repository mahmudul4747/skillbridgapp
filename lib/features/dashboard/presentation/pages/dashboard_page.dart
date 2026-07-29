import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    
      return SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good Morning 👋',
                          style: TextStyle(
                            fontSize: 15,
                            color: AppTheme.grayText,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Emran',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight:
                                FontWeight.bold,
                            color:
                                AppTheme.darkText,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withValues(alpha: 0.05),
                          blurRadius: 15,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.notifications_none_rounded,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // Career Score Card
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient:
                      const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppTheme.primaryBlue,
                      AppTheme.secondaryPurple,
                    ],
                  ),
                  borderRadius:
                      BorderRadius.circular(26),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryBlue
                          .withValues(alpha: 0.25),
                      blurRadius: 25,
                      offset:
                          const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your Career Score',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        const Text(
                          '78',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const Text(
                          ' / 100',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(10),
                      child:
                          LinearProgressIndicator(
                        value: 0.78,
                        minHeight: 8,
                        backgroundColor:
                            Colors.white24,
                        valueColor:
                            const AlwaysStoppedAnimation(
                          Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'Keep improving your skills 🚀',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              const Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkText,
                ),
              ),

              const SizedBox(height: 16),

              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 1.4,
                children: [
                  _QuickActionCard(
                    icon: Icons.description_outlined,
                    title: 'Build CV',
                    color: Colors.blue,
                    onTap: () {},
                  ),
                  _QuickActionCard(
                    icon: Icons.auto_awesome_outlined,
                    title: 'AI CV Analyzer',
                    color: Colors.purple,
                    onTap: () {},
                  ),
                  _QuickActionCard(
                    icon: Icons.psychology_outlined,
                    title: 'Skill Gap',
                    color: Colors.orange,
                    onTap: () {},
                  ),
                  _QuickActionCard(
                    icon: Icons.smart_toy_outlined,
                    title: 'AI Interview',
                    color: Colors.green,
                    onTap: () {},
                  ),
                ],
              ),

              const SizedBox(height: 28),

              const Text(
                'Your Career Roadmap',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkText,
                ),
              ),

              const SizedBox(height: 16),

              _RoadmapCard(
                title: 'Dart Fundamentals',
                status: 'Completed',
                progress: 1,
                icon: Icons.check_circle_rounded,
              ),

              const SizedBox(height: 12),

              _RoadmapCard(
                title: 'Flutter Development',
                status: 'In Progress',
                progress: 0.65,
                icon:
                    Icons.timelapse_rounded,
              ),

              const SizedBox(height: 12),

              _RoadmapCard(
                title: 'Firebase & REST API',
                status: 'Upcoming',
                progress: 0,
                icon:
                    Icons.lock_outline_rounded,
              ),
            ],
          ),
        ),
      );
    
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius:
          BorderRadius.circular(20),
      child: Container(
        padding:
            const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withValues(alpha: 0.04),
              blurRadius: 15,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color,
              size: 30,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontWeight:
                    FontWeight.w600,
                color:
                    AppTheme.darkText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoadmapCard
    extends StatelessWidget {
  final String title;
  final String status;
  final double progress;
  final IconData icon;

  const _RoadmapCard({
    required this.title,
    required this.status,
    required this.progress,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withValues(alpha: 0.04),
            blurRadius: 15,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: AppTheme.primaryBlue
                  .withValues(alpha: 0.1),
              shape: BoxShape.circle,
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
                    color:
                        AppTheme.darkText,
                  ),
                ),

                const SizedBox(height: 7),

                Text(
                  status,
                  style:
                      const TextStyle(
                    fontSize: 13,
                    color:
                        AppTheme.grayText,
                  ),
                ),

                const SizedBox(height: 8),

                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(
                          10),
                  child:
                      LinearProgressIndicator(
                    value: progress,
                    minHeight: 5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}