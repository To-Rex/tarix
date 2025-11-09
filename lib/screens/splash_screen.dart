import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../sample/auth/login_page.dart';
import 'onboarding_screen.dart';

class SplashScreens extends StatelessWidget {
  const SplashScreens({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      //Get.off(() => const OnboardingScreen());
      Get.off(() => LoginPage());
    });

    return Scaffold(
      backgroundColor: const Color(0xFF1976D2),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.science, size: 100, color: Colors.white),
            const SizedBox(height: 20),
            Text(
              'Fizika Qo‘llanma',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}