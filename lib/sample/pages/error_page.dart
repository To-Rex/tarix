import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../companents/filds/text_small.dart';
import '../../resource/app_colors.dart';
import '../../screens/splash_screen.dart';
import '../splash_screen.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/error.png', width: 200.w, height: 200.h),
            TextSmall(text: 'Server bilan aloqa yo‘q'.tr, color: AppColors.grey, fontSize: 24.sp, fontWeight: FontWeight.bold, maxLines: 300),
            SizedBox(height: 20.h),
            ElevatedButton(
                onPressed: () {
                  Get.offAll(() => SplashScreen());
                },
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r))),
                child: TextSmall(text: 'Qayta yuklash'.tr, color: AppColors.white, fontSize: 17.sp, fontWeight: FontWeight.w500, maxLines: 300)
            )
          ],
        )
      ),
    );
  }
}