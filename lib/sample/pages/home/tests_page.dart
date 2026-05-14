import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:history/sample/pages/home/test_detail.dart';
import '../../../companents/filds/text_small.dart';
import '../../../companents/refresh_component.dart';
import '../../../controllers/api_controller.dart';
import '../../../controllers/get_controller.dart';
import '../../../resource/app_colors.dart';

class TestsPage extends StatelessWidget {
  final String title;
  final String sId;
  TestsPage({super.key, required this.title, required this.sId});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    _getController.clearTestListModel();
    ApiController().getTestList();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        title: TextSmall(text: title, color: AppColors.black, fontSize: 20.sp, fontWeight: FontWeight.w500),
        centerTitle: false,
      ),
      body: RefreshComponent(
        color: AppColors.black,
        scrollController: _getController.scrollClassesController,
        physics: const ClampingScrollPhysics(),
        onRefresh: () async {
          _getController.clearTestListModel();
          await ApiController().getTestList();
        },
        child: Obx(() => _getController.testListModel.value.data != null
            ? _getController.testListModel.value.data!.isNotEmpty
            ? ListView.builder(
            itemCount: _getController.testListModel.value.data!.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(bottom: 150.h),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final test = _getController.testListModel.value.data![index];
              return Container(
                width: 1.sw,
                margin: EdgeInsets.only(top: 16.h, left: 15.w, right: 15.w),
                padding: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 15.w, right: 15.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: AppColors.white,
                    border: Border.all(color: AppColors.grey5)
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextSmall(
                          text: '${test.title}',
                          color: AppColors.black,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          TextSmall(
                              text: '${test.questionsCount ?? 0} ${'ttest'.tr}',
                              color: AppColors.lightGreen,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w400
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10.w, right: 10.w),
                            width: 10.w,
                            height: 10.w,
                            decoration: BoxDecoration(
                                color: AppColors.grey5,
                                borderRadius: BorderRadius.circular(16.r)
                            ),
                          ),
                          TextSmall(
                              text: '${test.minutes ?? 0} ${'daqiqa'.tr}',
                              color: AppColors.grey3,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w400
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 14.h, top: 20.h),
                        child: ElevatedButton(
                            onPressed: () {
                              Get.to(() => TestDetail(title: test.title ?? title));
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: AppColors.primaryColor,
                                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r))
                            ),
                            child: TextSmall(
                                text: 'Testni boshlash',
                                color: AppColors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold
                            )
                        ),
                      )
                    ]
                ),
              );
            })
            : Container(
            width: 1.sw,
            margin: const EdgeInsets.only(top: 18),
            padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 15.w),
            constraints: BoxConstraints(minHeight: Get.height - 200.h),
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r)
                )
            ),
            alignment: Alignment.center,
            child: TextSmall(
                text: 'Ma\'lumotlar yo\'q',
                color: AppColors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500
            ))
            : Skeletonizer(child: ListView.builder(
            itemCount: 5,
            shrinkWrap: true,
            padding: EdgeInsets.only(bottom: 150.h),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => Container(
                width: 1.sw,
                margin: EdgeInsets.only(top: 16.h, left: 15.w, right: 15.w),
                padding: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 15.w, right: 15.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: AppColors.white,
                    border: Border.all(color: AppColors.grey5)
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextSmall(
                          text: '8-sinf',
                          color: AppColors.black,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          TextSmall(
                              text: '60 ${'ttest'.tr}',
                              color: AppColors.lightGreen,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w400
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10.w, right: 10.w),
                            width: 10.w,
                            height: 10.w,
                            decoration: BoxDecoration(
                                color: AppColors.grey5,
                                borderRadius: BorderRadius.circular(16.r)
                            ),
                          ),
                          TextSmall(
                              text: '60 ${'daqiqa'.tr}',
                              color: AppColors.grey3,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w400
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 14.h, top: 20.h),
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: AppColors.primaryColor,
                                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r))
                            ),
                            child: TextSmall(
                                text: 'Testni boshlash',
                                color: AppColors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold
                            )
                        ),
                      )
                    ]
                ),
            ))
        )
      ),
    ));
  }
}
