import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../companents/filds/text_small.dart';
import '../../../companents/home/radio_option.dart';
import '../../../controllers/api_controller.dart';
import '../../../controllers/get_controller.dart';
import '../../../resource/app_colors.dart';

class TestDetail extends StatefulWidget {
  final String title;
  final String sId;

  TestDetail({super.key, required this.title, required this.sId});

  @override
  State<TestDetail> createState() => _TestDetailState();
}

class _TestDetailState extends State<TestDetail> {
  late final GetController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(GetController());
    _controller.resetTest();
    ApiController().startTest(widget.sId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Obx(() {
        if (_controller.questions.isEmpty) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        }

        return Container(
        width: 1.sw,
        height: 1.sh,
        margin: EdgeInsets.only(top: 65.h, left: 15.w, right: 15.w, bottom: 50.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.grey, width: 1.w),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 5.sp),
              // Top Bar (Timer and Finish Button)
              Container(
                width: 1.sw,
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                padding: EdgeInsets.symmetric(vertical: 10.h),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.r),
                    topRight: Radius.circular(15.r),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      height: 55.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: AppColors.grey, width: 1.w),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.timer, color: AppColors.primaryColor, size: 25.sp),
                          SizedBox(width: 5.w),
                          TextSmall(
                            text: _controller.timerText.value,
                            color: AppColors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 13.h),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.r))),
                      ),
                      onPressed: _controller.finishTest,
                      child: TextSmall(
                        text: 'Yakunlash',
                        color: AppColors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(thickness: 1.w, color: AppColors.grey),
              // Question and Options
              Expanded(
                child: Container(
                  width: 1.sw,
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Question Content
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextSmall(
                            text: '№${_controller.currentQuestionIndex.value + 1}',
                            color: AppColors.grey4,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(height: 10.h),
                          TextSmall(
                            text: _controller.questions[_controller.currentQuestionIndex.value].text,
                            color: AppColors.black,
                            maxLines: 10000,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(height: 10.h),
                          Divider(thickness: 1.w, color: AppColors.grey),
                          // Options
                          ..._controller.questions[_controller.currentQuestionIndex.value].options.map((option) {
                            return RadioOption(
                              text: option.text,
                              value: option.value,
                              groupValue: _controller.selectedAnswers[_controller.currentQuestionIndex.value] ?? '',
                              onChanged: (value) => _controller.selectAnswer(value!),
                            );
                          }).toList(),
                        ],
                      ),
                      // Navigation Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Orqaga Button
                          Visibility(
                            visible: _controller.currentQuestionIndex.value > 0,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                                alignment: Alignment.center,
                                backgroundColor: AppColors.white,
                                side: BorderSide(color: AppColors.grey, width: 1.w),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.r))),
                              ),
                              onPressed: _controller.previousQuestion,
                              child: Row(
                                children: [
                                  Icon(Icons.arrow_back_ios, color: AppColors.black, size: 18.sp),
                                  SizedBox(width: 5.sp),
                                  TextSmall(
                                    text: 'Avvalgisi',
                                    color: AppColors.black,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Keyingisi Button
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.r))),
                            ),
                            onPressed: _controller.nextQuestion,
                            child: Row(
                              children: [
                                TextSmall(
                                  text: 'Keyingisi',
                                  color: AppColors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                SizedBox(width: 5.sp),
                                Icon(Icons.arrow_forward_ios, color: AppColors.white, size: 18.sp),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Divider(thickness: 1.w, color: AppColors.grey),
              // Question Numbers
              Container(
                width: 1.sw,
                height: 70.h,
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.r),
                    topRight: Radius.circular(15.r),
                  ),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: _controller.scrollQuestionsController,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: _controller.questions.asMap().entries.map((entry) {
                      final index = entry.key;
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: QuestionNumber(
                          number: '${index + 1}',
                          isActive: _controller.currentQuestionIndex.value == index,
                          isAnswered: _controller.selectedAnswers.containsKey(index),
                          onTap: () => _controller.goToQuestion(index),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
