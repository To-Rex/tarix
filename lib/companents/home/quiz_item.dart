import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/get_controller.dart';
import '../../resource/app_colors.dart';
import '../../sample/pages/home/questions_page.dart';
import '../filds/text_small.dart';

class QuizItem extends StatelessWidget {
  final String sId;
  final int index;
  final String question;
  final String answer;
  QuizItem({super.key, required this.sId, required this.index, required this.question, required this.answer});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    _getController.setHeightWidth(context);
    return Container(
        width: 1.sw,
        margin: EdgeInsets.only(top: 16.h),
        padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r), color: AppColors.white, border: Border.all(color: AppColors.grey6)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: TextSmall(text: '${index+1}-${'Savol'.tr}:', color: AppColors.grey3, fontSize: 18.sp, fontWeight: FontWeight.w500, maxLines: 300),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: TextSmall(text: question, color: AppColors.black, fontSize: 20.sp, fontWeight: FontWeight.w500, maxLines: 300),
              ),
              const Divider(color: AppColors.grey6, thickness: 1),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: TextSmall(text: '${'Javob'.tr}:', color: AppColors.grey3, fontSize: 18.sp, fontWeight: FontWeight.w500, maxLines: 300),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: TextSmall(text: answer, color: AppColors.lightGreen, fontSize: 20.sp, fontWeight: FontWeight.w500, maxLines: 300),
              ),
            ]
        ),
    );
  }
}