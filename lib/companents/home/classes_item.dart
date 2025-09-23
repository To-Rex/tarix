import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/get_controller.dart';
import '../../resource/app_colors.dart';
import '../../sample/pages/home/classes_page.dart';
import '../../sample/pages/home/presentation_page.dart';
import '../../sample/pages/home/questions_page.dart';
import '../filds/text_small.dart';

class ClassesItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String sId;
  final String type;
  ClassesItem({super.key,required this.title, required this.sId, required this.subtitle, required this.type});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    _getController.setHeightWidth(context);
    return Container(
        width: 1.sw,
        margin: EdgeInsets.only(top: 16.h),
        padding: EdgeInsets.only(top: 10.h),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r), color: AppColors.white, border: Border.all(color: AppColors.grey6)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.symmetric(horizontal: 15.w), child: TextSmall(text: title, color: AppColors.black, fontSize: 24.sp, fontWeight: FontWeight.bold)),
              Container(
                  margin: EdgeInsets.only(left: 15.w, bottom: 14.h, top: 10.h),
                  child: ElevatedButton(
                      onPressed: () {
                        print(type);
                        //Get.to(() => PresentationPage(title: title, sId: sId, type: type, isGrade: true));
                        if (type == 'presentation') {
                          Get.to(() => PresentationPage(title: title, sId: sId, type: type, isGrade: true));
                        } else if(type == 'quiz') {
                          print('classes');
                          //Get.to(() => ClassesPage(title: title, sId: sId, type: type));
                          Get.to(() => QuestionsPage(title: title, sId: sId));
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