import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../companents/filds/text_small.dart';
import '../../../controllers/get_controller.dart';
import '../../../resource/app_colors.dart';

class QuestionInfoPage extends StatelessWidget {
  QuestionInfoPage({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    _getController.setHeightWidth(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: TextSmall(
          text: 'Test natijalari',
          color: AppColors.black,
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ikonka
            Icon(
              Icons.info_outline,
              size: 80.sp,
              color: AppColors.black.withOpacity(0.6),
            ),
            SizedBox(height: 20.h),
            // Asosiy xabar
            TextSmall(
              text: "Hozircha ma'lumotlar mavjud emas",
              color: AppColors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),
            // Qo'shimcha izoh
            TextSmall(
              text: "Iltimos, keyinroq qayta urinib ko'ring yoki ma'lumotlarni yangilang.",
              color: AppColors.black.withOpacity(0.6),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
            SizedBox(height: 40.h)
          ]
        )
      )
    );
  }
}