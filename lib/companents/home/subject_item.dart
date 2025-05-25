import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tarix/sample/pages/home/classes_page.dart';
import 'package:tarix/sample/pages/home/tests_page.dart';
import '../../controller/get_controller.dart';
import '../../resource/app_colors.dart';
import '../../sample/pages/home/presentation_page.dart';
import '../filds/text_small.dart';

class SubjectItem extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final int index;
  final String sId;
  final String type;
  final bool withGrade;
  SubjectItem({super.key, required this.image, required this.title, required this.index, required this.sId, required this.type, required this.withGrade, required this.subtitle});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    _getController.setHeightWidth(context);
    return Container(
        width: 1.sw,
        margin: EdgeInsets.only(top: 16.h),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r), color: AppColors.white, border: Border.all(color: AppColors.grey6)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(padding: EdgeInsets.symmetric(horizontal: 15.w), child: TextSmall(text: title, color: AppColors.black, fontSize: 24.sp, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Container(
                    width: 58.w,
                    height: 58.h,
                    margin: EdgeInsets.only(right: 15.w, top: 15.h),
                    padding: EdgeInsets.all(5.sp),
                    decoration: BoxDecoration(color: AppColors.grey6, borderRadius: BorderRadius.circular(10.r)),
                    child: Container(padding: EdgeInsets.all(5.sp), decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(10.r)),
                        child: image == ''
                            ? Container(width: 50.w, height: 50.h, decoration: BoxDecoration(color: AppColors.grey6, borderRadius: BorderRadius.circular(10.r)))
                            : image.contains('.svg')
                            ? SvgPicture.network(image, fit: BoxFit.cover)
                            : Image.network(image, fit: BoxFit.cover)
                    )
                  )
                ]
              ),
              Container(
                  margin: EdgeInsets.only(left: 15.w, bottom: 14.h),
                  child: ElevatedButton(
                      onPressed: () {
                        print(type);
                        if (type == 'quiz') {
                          Get.to(() => ClassesPage(title: title, sId: sId, type: type));
                        } else if (type == 'presentation') {
                          Get.to(() => withGrade != true
                              ? PresentationPage(title: title, sId: sId, type: type, isGrade: false)
                              : ClassesPage(title: title, sId: sId, type: type));
                        } else {
                          Get.to(() => TestsPage(title: title));
                        }
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
        ),
    );
  }
}