import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tarix/controller/get_controller.dart';
import 'package:tarix/sample/pages/home/test_detail.dart';
import '../../../companents/filds/text_small.dart';
import '../../../resource/app_colors.dart';

class TestsPage extends StatelessWidget {
  final String title;
  TestsPage({super.key, required this.title});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        title: TextSmall(text: title, color: AppColors.black, fontSize: 20.sp, fontWeight: FontWeight.w500),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20.h, left: 15.w, right: 15.w),
            padding: EdgeInsets.all(15.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: AppColors.lightGreen,
              border: Border.all(color: AppColors.grey, width: 1.w)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Text('To‘lov amalga oshirilgan', style: TextStyle(color: AppColors.white, fontSize: 20.sp, fontWeight: FontWeight.w500),),
                TextSmall(text: 'To‘lov amalga oshirilgan', color: AppColors.white, fontSize: 20.sp, fontWeight: FontWeight.w500),
                const Icon(FluentIcons.checkmark_square_20_filled, color: AppColors.white)
              ],
            )
          ),
          Container(
            width: 1.sw,
            margin: EdgeInsets.only(top: 16.h, left: 15.w, right: 15.w),
            padding: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 15.w, right: 15.w),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r), color: AppColors.white, border: Border.all(color: AppColors.grey5)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextSmall(text: '6-${'sinf'.tr}', color: AppColors.black, fontSize: 24.sp, fontWeight: FontWeight.bold),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      TextSmall(text: '60 ${'ttest'.tr}', color: AppColors.lightGreen, fontSize: 20.sp, fontWeight: FontWeight.w400),
                      Container(
                        margin: EdgeInsets.only(left: 10.w, right: 10.w),
                        width: 10.w,
                        height: 10.w,
                        decoration: BoxDecoration(
                          color: AppColors.grey5,
                          borderRadius: BorderRadius.circular(16.r)
                        ),
                      ),
                      TextSmall(text: '60 ${'daqiqa'.tr}', color: AppColors.grey3, fontSize: 20.sp, fontWeight: FontWeight.w400),
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(bottom: 14.h, top: 20.h),
                      child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => TestDetail(title: title));
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: AppColors.primaryColor,
                              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r))
                          ),
                          child: TextSmall(text: 'Testni boshlash', color: AppColors.white, fontSize: 18.sp, fontWeight: FontWeight.bold)
                      )
                  )
                ]
            ),
          ),
        ],
      )
    );
  }
}