import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return Scaffold(
      body: Obx(
            () => Stack(
          children: [
            // Gradient fon
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: Get.isDarkMode
                      ? [const Color(0xFF1C2526), const Color(0xFF2E3B3E)]
                      : [const Color(0xFFF5F7FA), const Color(0xFFE3F2FD)],
                ),
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: controller.pageController,
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.pages.length,
                    onPageChanged: (index) => controller.currentPage.value = index,
                    itemBuilder: (context, index) {
                      return Obx(
                            () => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              transform: Matrix4.identity()
                                ..scale(controller.currentPage.value == index ? 1.0 : 0.8),
                              child: Lottie.asset(
                                controller.pages[index]['lottie'] as String,
                                width: 200,
                                height: 200,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 20),
                            AnimatedOpacity(
                              duration: const Duration(milliseconds: 400),
                              opacity: controller.currentPage.value == index ? 1.0 : 0.7,
                              child: Text(
                                controller.pages[index]['title'] as String,
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 400),
                                opacity: controller.currentPage.value == index ? 1.0 : 0.7,
                                child: Text(
                                  controller.pages[index]['description'] as String,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 16,
                                    color: Get.isDarkMode ? Colors.grey[400] : Colors.grey[600],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // Nuqtali indikator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    controller.pages.length,
                        (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      width: controller.currentPage.value == index ? 12 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: controller.currentPage.value == index
                            ? (Get.isDarkMode ? const Color(0xFF42A5F5) : const Color(0xFF1976D2))
                            : (Get.isDarkMode ? Colors.grey[700] : Colors.grey[400]),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Tugmalar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: controller.currentPage.value == 0 ? 0.0 : 1.0,
                        child: TextButton(
                          onPressed: controller.skip,
                          child: Text(
                            'skip'.tr,
                            style: TextStyle(
                              color: Get.isDarkMode ? const Color(0xFF42A5F5) : const Color(0xFF1976D2),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: controller.nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Get.isDarkMode ? const Color(0xFF42A5F5) : const Color(0xFF1976D2),
                          foregroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                          elevation: 5,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: Text(
                          controller.currentPage.value == controller.pages.length - 1 ? 'start'.tr : 'next'.tr,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ],
        ),
      ),
    );
  }
}