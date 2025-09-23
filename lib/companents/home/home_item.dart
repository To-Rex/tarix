import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/get_controller.dart';
import '../../resource/app_colors.dart';
import '../../sample/pages/home/detailed_page.dart';
import '../filds/text_small.dart';
import '../settings/chashe_image.dart';

class HomeItem extends StatelessWidget {
  final String image;
  final String title;
  final int index;
  final String sId;
  HomeItem({super.key, required this.image, required this.title, required this.index, required this.sId});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    _getController.setHeightWidth(context);
    return Container(
        width: 1.sw,
        height: 308.h,
        margin: EdgeInsets.only(top: 16.h),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r), color: AppColors.white, border: Border.all(color: AppColors.grey6)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: 1.sw,
                height: 175.h,
                decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(15.r), topRight: Radius.circular(15.r))),
                child: CacheImage(url: image,fit: BoxFit.fill)
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: TextSmall(text: title, color: AppColors.black, fontSize: 24.sp, fontWeight: FontWeight.bold)
            ),
            const Spacer(),
            Container(
              margin: EdgeInsets.only(left: 15.w, bottom: 14.h),
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => DetailedPage(sId: sId, title: title));
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: AppColors.primaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r))
                ),
                child: TextSmall(text: 'Batafsil ko‘rish', color: AppColors.white, fontSize: 18.sp, fontWeight: FontWeight.bold)
              )
            )
          ]
        )
    );
  }
}