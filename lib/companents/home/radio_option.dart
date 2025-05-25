import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../companents/filds/text_small.dart';
import '../../../resource/app_colors.dart';

class RadioOption extends StatelessWidget {
  final String text;
  final String value;
  final String groupValue;
  final Function(String?) onChanged;

  const RadioOption({
    super.key,
    required this.text,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RadioMenuButton(
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      child: TextSmall(
        text: text,
        color: AppColors.black,
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class QuestionNumber extends StatelessWidget {
  final String number;
  final bool isActive;

  const QuestionNumber({
    super.key,
    required this.number,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      height: 50.w,
      width: 50.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isActive ? AppColors.lightGreen : AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.grey, width: 1.w),
      ),
      child: TextSmall(
        text: number,
        color: isActive ? AppColors.white : AppColors.black,
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}