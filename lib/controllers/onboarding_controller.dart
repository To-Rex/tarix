import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/home_screen.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;
  final PageController pageController = PageController();

  final pages = [
    {
      'title': 'Fizika Qo‘llanmasiga Xush Kelibsiz!',
      'description': 'Fizika bo‘yicha asosiy tushunchalar va formulalarni oson o‘rganing.',
      'lottie': 'assets/lottie/science.json',
    },
    {
      'title': 'Mavzular va Savollar',
      'description': 'Har bir mavzu bo‘yicha ma’lumot va savollar bilan bilimlaringizni mustahkamlang.',
      'lottie': 'assets/lottie/book.json',
    },
    {
      'title': 'Qulay Sozlamalar',
      'description': 'Til, tungi rejim va boshqa sozlamalarni o‘zingizga moslang.',
      'lottie': 'assets/lottie/settings.json',
    },
  ];

  void nextPage() {
    if (currentPage.value < pages.length - 1) {
      currentPage.value++;
      pageController.animateToPage(
        currentPage.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  void skip() {
    Get.offAll(() => const HomeScreen());
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}