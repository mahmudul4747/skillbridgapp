import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
          'My Profile',
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
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor:
                      AppTheme.primaryBlue
                          .withValues(
                    alpha: 0.1,
                  ),
                  child: const Icon(
                    Icons.person_rounded,
                    size: 45,
                    color:
                        AppTheme.primaryBlue,
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  'Emran Hossain',
                  style:
                      TextStyle(
                    fontSize: 22,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  'Flutter Developer',
                  style:
                      TextStyle(
                    color:
                        AppTheme.grayText,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          _ProfileItem(
            icon:
                Icons.person_outline_rounded,
            title: 'Edit Profile',
          ),

          _ProfileItem(
            icon:
                Icons.description_outlined,
            title: 'My CV',
          ),

          _ProfileItem(
            icon:
                Icons.settings_outlined,
            title: 'Settings',
          ),

          _ProfileItem(
            icon:
                Icons.logout_rounded,
            title: 'Logout',
          ),
        ],
      ),
    );
  }
}

class _ProfileItem
    extends StatelessWidget {
  final IconData icon;
  final String title;

  const _ProfileItem({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          const EdgeInsets.only(
        bottom: 12,
      ),
      decoration:
          BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color:
              AppTheme.primaryBlue,
        ),
        title: Text(
          title,
          style:
              const TextStyle(
            fontWeight:
                FontWeight.w600,
          ),
        ),
        trailing: const Icon(
          Icons
              .arrow_forward_ios_rounded,
          size: 16,
        ),
      ),
    );
  }
}