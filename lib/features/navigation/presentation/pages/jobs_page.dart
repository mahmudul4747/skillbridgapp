import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';

class JobsPage extends ConsumerWidget {
  const JobsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FC),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Find Your Dream Job',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppTheme.darkText,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search jobs...',
              prefixIcon: const Icon(
                Icons.search_rounded,
              ),
              suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.tune_rounded,
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Recommended Jobs',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.darkText,
            ),
          ),

          const SizedBox(height: 16),

          _JobCard(
            title: 'Flutter Developer',
            company: 'Tech Company',
            location: 'Remote',
          ),

          _JobCard(
            title: 'Junior Android Developer',
            company: 'Software Company',
            location: 'Dhaka',
          ),

          _JobCard(
            title: 'Frontend Developer',
            company: 'Startup',
            location: 'Remote',
          ),
        ],
      ),
    );
  }
}

class _JobCard extends StatelessWidget {
  final String title;
  final String company;
  final String location;

  const _JobCard({
    required this.title,
    required this.company,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 14,
      ),
      padding: const EdgeInsets.all(18),
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
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              color: AppTheme.primaryBlue
                  .withValues(alpha: 0.1),
              borderRadius:
                  BorderRadius.circular(15),
            ),
            child: const Icon(
              Icons.business_center_rounded,
              color:
                  AppTheme.primaryBlue,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight:
                        FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  company,
                  style: const TextStyle(
                    color:
                        AppTheme.grayText,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  location,
                  style: const TextStyle(
                    fontSize: 13,
                    color:
                        AppTheme.primaryBlue,
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
          ),
        ],
      ),
    );
  }
}