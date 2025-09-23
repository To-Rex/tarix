import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/physics_controller.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PhysicsController>();

    return Scaffold(
      backgroundColor: Theme.of(context).cardTheme.color,
      appBar: AppBar(
        title: Text('language'.tr),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text('O‘zbekcha', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
              trailing: Obx(() => Icon(
                controller.selectedLanguage.value == 'uz' ? Icons.check_circle : Icons.circle_outlined,
                color: Color(0xFF1976D2),
              )),
              onTap: () {
                controller.changeLanguage('uz');
                Get.back();
              },
            ),
            ListTile(
              title: Text('English', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
              trailing: Obx(() => Icon(
                controller.selectedLanguage.value == 'en' ? Icons.check_circle : Icons.circle_outlined,
                color: Color(0xFF1976D2),
              )),
              onTap: () {
                controller.changeLanguage('en');
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}