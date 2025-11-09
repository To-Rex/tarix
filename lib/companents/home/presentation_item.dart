import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/get_controller.dart';
import '../../resource/app_colors.dart';
import '../../sample/pages/other/pptx_reader.dart';
import '../filds/text_small.dart';
import '../settings/instrument_components.dart';

class PresentationItem extends StatelessWidget {
  final String title;
  final String sId;
  final String file;
  final String size;
  final String mimetype;
  final String price;
  final bool isFree;
  PresentationItem({super.key,required this.title, required this.sId, required this.file, required this.size, required this.mimetype, required this.price, required this.isFree,});

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
              SizedBox(height: 5.h),
              Padding(padding: EdgeInsets.symmetric(horizontal: 15.w), child: TextSmall(text: title, color: AppColors.black, fontSize: 20.sp, fontWeight: FontWeight.bold, maxLines: 2)),
              SizedBox(height: 5.h),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Row(
                      children: [
                        TextSmall(text: size, color: AppColors.lightGreen, fontSize: 20.sp, fontWeight: FontWeight.bold),
                        SizedBox(width: 5.w),
                        Icon(Icons.circle, color: AppColors.grey5, size: 10.sp),
                        SizedBox(width: 5.w),
                        TextSmall(text: mimetype, color: AppColors.grey3, fontSize: 20.sp, fontWeight: FontWeight.w600)
                      ]
                  )
              ),
              Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 15.w, bottom: 14.h, top: 15.h, right: 15.w),
                      child: ElevatedButton(
                          onPressed: () {
                            if (!isFree) {
                              InstrumentComponents().bottomSheetPayment();
                            } else {
                              if (file != '') {
                                Get.to(() => PptxReader(url: file));
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: AppColors.primaryColor,
                              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r))
                          ),
                          child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(!isFree ? Icons.lock : Icons.remove_red_eye, color: AppColors.white, size: 25.sp),
                                SizedBox(width: 6.w),
                                TextSmall(text: 'ko‘rish', color: AppColors.white, fontSize: 18.sp, fontWeight: FontWeight.bold)
                              ]
                          )
                      )
                  )
                ]
              )
            ]
        )
    );
  }
}