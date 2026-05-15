import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../companents/filds/text_small.dart';
import '../../../controllers/api_controller.dart';
import '../../../controllers/get_controller.dart';
import '../../../resource/app_colors.dart';

class QuestionInfoPage extends StatelessWidget {
  QuestionInfoPage({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    _getController.setHeightWidth(context);
    ApiController().getTestAnswerList();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: TextSmall(text: 'Test natijalari', color: AppColors.black, fontSize: 20.sp, fontWeight: FontWeight.w500),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      body: Obx(() {
        final data = _getController.testAnswerListModel.value.data;
        if (data == null || data.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.info_outline, size: 80.sp, color: AppColors.grey3),
                SizedBox(height: 20.h),
                TextSmall(text: "Hozircha ma'lumotlar mavjud emas", color: AppColors.black, fontSize: 18.sp, fontWeight: FontWeight.w600, textAlign: TextAlign.center),
                SizedBox(height: 10.h),
                TextSmall(text: "Iltimos, keyinroq qayta urinib ko'ring yoki ma'lumotlarni yangilang.", color: AppColors.grey3, fontSize: 14.sp, fontWeight: FontWeight.w400, textAlign: TextAlign.center, maxLines: 2),
                SizedBox(height: 40.h),
              ],
            ),
          );
        }
        return ListView.builder(
          itemCount: data.length,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          itemBuilder: (context, index) {
            final item = data[index];
            return _buildResultCard(item);
          },
        );
      }),
    );
  }

  Widget _buildResultCard(dynamic item) {
    final test = item.test;
    final ball = item.ball ?? 0;
    final ballPercent = item.ballPercent ?? 0.0;

    Color percentColor;
    if (ballPercent >= 80) {
      percentColor = AppColors.lightGreen;
    } else if (ballPercent >= 50) {
      percentColor = AppColors.primaryColor;
    } else {
      percentColor = AppColors.red;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: AppColors.white,
        border: Border.all(color: AppColors.grey5),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextSmall(text: test?.title ?? '', color: AppColors.black, fontSize: 18.sp, fontWeight: FontWeight.bold),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Icon(Icons.timer, color: AppColors.grey3, size: 16.sp),
                    SizedBox(width: 4.w),
                    TextSmall(text: '${test?.minutes ?? 0} ${'daqiqa'.tr}', color: AppColors.grey3, fontSize: 14.sp, fontWeight: FontWeight.w400),
                    SizedBox(width: 16.w),
                    Icon(Icons.quiz_outlined, color: AppColors.grey3, size: 16.sp),
                    SizedBox(width: 4.w),
                    TextSmall(text: '$ball ${'ball'.tr}', color: AppColors.grey3, fontSize: 14.sp, fontWeight: FontWeight.w400),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: percentColor.withValues(alpha: 0.1),
            ),
            alignment: Alignment.center,
            child: TextSmall(
              text: '${ballPercent.round()}%',
              color: percentColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
