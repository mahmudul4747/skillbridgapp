import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'firebase_options.dart';

import 'shared/providers/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: SkillBridgeApp(),
    ),
  );
}

class SkillBridgeApp extends ConsumerWidget {
  const SkillBridgeApp({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'SkillBridge',
      theme: AppTheme.lightTheme,
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
        primaryColor: AppTheme.primaryBlue,
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}