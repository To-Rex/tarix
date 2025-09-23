import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/physics_controller.dart';
import '../screens/home_screen.dart';
import '../screens/about_screen.dart';
import '../screens/language_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PhysicsController>();

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: Get.isDarkMode
                    ? [const Color(0xFF1E1E1E), const Color(0xFF121212)]
                    : [const Color(0xFF1976D2), const Color(0xFF1565C0)],
              ),
            ),
            child: Center(
              child: Text(
                'app_name'.tr,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Get.isDarkMode ? const Color(0xFFE0E0E0) : Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Theme.of(context).iconTheme.color,
            ),
            title: Text(
              'home'.tr,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            onTap: () {
              Get.back();
              Get.to(() => const HomeScreen());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.info,
              color: Theme.of(context).iconTheme.color,
            ),
            title: Text(
              'about'.tr,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            onTap: () {
              Get.back();
              Get.to(() => const AboutScreen());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.language,
              color: Theme.of(context).iconTheme.color,
            ),
            title: Text(
              'language'.tr,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            onTap: () {
              Get.back();
              Get.to(() => const LanguageScreen());
            },
          ),
          Obx(
                () => SwitchListTile(
              secondary: Icon(
                Icons.brightness_6,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(
                'theme'.tr,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              value: controller.isDarkMode.value,
              onChanged: (value) => controller.toggleTheme(),
              activeColor: const Color(0xFF42A5F5),
              inactiveThumbColor: const Color(0xFF1976D2),
            ),
          ),
        ],
      ),
    );
  }
}