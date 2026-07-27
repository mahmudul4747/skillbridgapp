import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skillbridg/features/auth/presentation/providers/auth_provider.dart';

import '../../../../core/theme/app_theme.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  bool _obscurePassword = true;
final emailController =
    TextEditingController();

final passwordController =
    TextEditingController();

@override
void dispose() {
  emailController.dispose();
  passwordController.dispose();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),

              // Logo
              Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      AppTheme.primaryBlue,
                      AppTheme.secondaryPurple,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.rocket_launch_rounded,
                  color: Colors.white,
                  size: 32,
                ),
              ),

              const SizedBox(height: 35),

              const Text(
                'Welcome Back 👋',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkText,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Login to continue your career journey.',
                style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.grayText,
                ),
              ),

              const SizedBox(height: 40),

              const Text(
                'Email Address',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.darkText,
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                  prefixIcon: Icon(
                    Icons.email_outlined,
                  ),
                ),
              ),

              const SizedBox(height: 22),

              const Text(
                'Password',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.darkText,
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  prefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscurePassword =
                            !_obscurePassword;
                      });
                    },
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot Password?',
                  ),
                ),
              ),

              const SizedBox(height: 16),

              ElevatedButton(
  onPressed: () async {
    try {
      await ref
          .read(authProvider.notifier)
          .login(
            email: emailController.text.trim(),
            password:
                passwordController.text.trim(),
          );

      if (!mounted) return;

      context.go('/dashboard');
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            'Login failed: $e',
          ),
        ),
      );
    }
  },
  child: const Text('Login'),
),
const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Text(
                      'OR',
                      style: TextStyle(
                        color: AppTheme.grayText,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade300,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.g_mobiledata_rounded,
                  size: 30,
                ),
                label: const Text(
                  'Continue with Google',
                ),
                style: OutlinedButton.styleFrom(
                  minimumSize:
                      const Size(double.infinity, 54),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(16),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      color: AppTheme.grayText,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.go('/register');
                    },
                    child: const Text(
                      'Create Account',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}