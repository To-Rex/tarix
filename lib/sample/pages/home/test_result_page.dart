import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../companents/filds/text_small.dart';
import '../../../models/question_model.dart';
import '../../../resource/app_colors.dart';

class TestResultPage extends StatelessWidget {
  final String title;
  final List<QuestionModel> questions;
  final Map<int, String> selectedAnswers;
  final int correctCount;
  final int totalCount;
  final String elapsedTime;

  const TestResultPage({
    super.key,
    required this.title,
    required this.questions,
    required this.selectedAnswers,
    required this.correctCount,
    required this.totalCount,
    required this.elapsedTime,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = totalCount > 0 ? (correctCount / totalCount * 100).round() : 0;
    final incorrectCount = totalCount - correctCount;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        title: TextSmall(text: title, color: AppColors.black, fontSize: 20.sp, fontWeight: FontWeight.w500),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            _buildScoreCircle(percentage),
            SizedBox(height: 16.h),
            _buildStatsRow(correctCount, incorrectCount, totalCount),
            SizedBox(height: 8.h),
            _buildTimeRow(),
            SizedBox(height: 24.h),
            _buildQuestionList(),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreCircle(int percentage) {
    Color scoreColor;
    if (percentage >= 80) {
      scoreColor = AppColors.lightGreen;
    } else if (percentage >= 50) {
      scoreColor = AppColors.primaryColor;
    } else {
      scoreColor = AppColors.red;
    }

    return SizedBox(
      width: 140.w,
      height: 140.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 140.w,
            height: 140.w,
            child: CircularProgressIndicator(
              value: percentage / 100,
              strokeWidth: 10.w,
              backgroundColor: AppColors.grey6,
              valueColor: AlwaysStoppedAnimation<Color>(scoreColor),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextSmall(
                text: '$percentage%',
                color: scoreColor,
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
              ),
              TextSmall(
                text: 'to\'g\'ri'.tr,
                color: AppColors.grey3,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(int correct, int incorrect, int total) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.grey8,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('To\'g\'ri'.tr, '$correct', AppColors.lightGreen),
          Container(width: 1.w, height: 30.h, color: AppColors.grey5),
          _buildStatItem('Noto\'g\'ri'.tr, '$incorrect', AppColors.red),
          Container(width: 1.w, height: 30.h, color: AppColors.grey5),
          _buildStatItem('Jami'.tr, '$total', AppColors.black),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextSmall(text: value, color: color, fontSize: 22.sp, fontWeight: FontWeight.bold),
        SizedBox(height: 4.h),
        TextSmall(text: label, color: AppColors.grey3, fontSize: 14.sp, fontWeight: FontWeight.w400),
      ],
    );
  }

  Widget _buildTimeRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.timer, color: AppColors.grey3, size: 20.sp),
        SizedBox(width: 6.w),
        TextSmall(text: '${'Sarflangan vaqt'.tr}: $elapsedTime', color: AppColors.grey3, fontSize: 16.sp, fontWeight: FontWeight.w400),
      ],
    );
  }

  Widget _buildQuestionList() {
    return ListView.separated(
      itemCount: questions.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, _) => SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        final question = questions[index];
        final selected = selectedAnswers[index];
        final correctOption = question.options.where((o) => o.isCorrect).toList();
        final isCorrect = selected != null && correctOption.isNotEmpty && correctOption.first.value == selected;

        return Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: isCorrect ? AppColors.lightGreen2 : AppColors.red.withValues(alpha: 0.3)),
            color: isCorrect ? AppColors.grey8 : AppColors.red.withValues(alpha: 0.05),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    isCorrect ? Icons.check_circle : Icons.cancel,
                    color: isCorrect ? AppColors.lightGreen : AppColors.red,
                    size: 20.sp,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: TextSmall(
                      text: '${index + 1}. ${question.text}',
                      color: AppColors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      maxLines: 5,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              ...question.options.map((option) {
                final isSelected = option.value == selected;
                final isRight = option.isCorrect;
                Color bgColor = AppColors.white;
                Color textColor = AppColors.black;
                if (isSelected && isRight) {
                  bgColor = AppColors.lightGreen.withValues(alpha: 0.15);
                  textColor = AppColors.lightGreen;
                } else if (isSelected && !isRight) {
                  bgColor = AppColors.red.withValues(alpha: 0.1);
                  textColor = AppColors.red;
                } else if (!isSelected && isRight) {
                  bgColor = AppColors.lightGreen.withValues(alpha: 0.08);
                  textColor = AppColors.lightGreen2;
                }
                return Container(
                  margin: EdgeInsets.only(bottom: 4.h),
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: TextSmall(
                    text: '${option.value}. ${option.text}',
                    color: textColor,
                    fontSize: 14.sp,
                    fontWeight: isSelected || isRight ? FontWeight.w600 : FontWeight.w400,
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
