import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tarix/resource/app_colors.dart';

import 'filds/text_small.dart';

class CustomRefreshHeader extends StatelessWidget {
  final Color? color;
  const CustomRefreshHeader({super.key, this.color = Colors.white});
  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      height: 120.sp,
      builder: (BuildContext context, RefreshStatus? mode) {
        Widget body;
        if (mode == RefreshStatus.idle) {
          //body = TextSmall(text: 'Ma’lumotlarni yangilash uchun tashlang'.tr, fontSize: 14.sp, color: color ?? Colors.white, fontWeight: FontWeight.w400);
          body = CustomMessageText(text: 'Ma’lumotlarni yangilash uchun tashlang'.tr, color: color ?? Colors.white, fontSize: 14.sp, isText: true);
        } else if (mode == RefreshStatus.refreshing) {
          //body = Container(margin: EdgeInsets.only(top: 20.sp), child: const CircularProgressIndicator(color: Colors.blue, backgroundColor: Colors.white, strokeWidth: 2));
          body = CustomMessageText(text: 'Ma’lumotlarni yangilash uchun tashlang'.tr, color: color ?? Colors.white, fontSize: 14.sp, isText: false);
        } else if (mode == RefreshStatus.failed) {
          //body = TextSmall(text: 'Ehhh nimadir xato ketdi'.tr, fontSize: 14.sp, color: color ?? Colors.white, fontWeight: FontWeight.w400);
          body = CustomMessageText(text: 'Ehhh nimadir xato ketdi'.tr, color: color ?? Colors.white, fontSize: 14.sp, isText: true);
        } else if (mode == RefreshStatus.canRefresh) {
          //body = TextSmall(text: 'Ma’lumotlarni yangilash uchun tashlang'.tr, fontSize: 14.sp, color: color ?? Colors.white, fontWeight: FontWeight.w400);
          body = CustomMessageText(text: 'Ma’lumotlarni yangilash uchun tashlang'.tr, color: color ?? Colors.white, fontSize: 14.sp, isText: true);
        } else {
          //body = TextSmall(text: 'Ma’lumotlar yangilandi'.tr, fontSize: 14.sp, color: color ?? Colors.white, fontWeight: FontWeight.w400);
          body = CustomMessageText(text: 'Ma’lumotlar yangilandi'.tr, color: color ?? Colors.white, fontSize: 14.sp, isText: true);
        }
        return SizedBox(height: 60.sp, child: Center(child: body));
      }
    );
  }
}

class CustomRefreshFooter extends StatelessWidget {
  final Color? color;
  const CustomRefreshFooter({super.key, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = const SizedBox();
        } else if (mode == LoadStatus.loading) {
          //body = const CircularProgressIndicator(color: Colors.blue, backgroundColor: Colors.white, strokeWidth: 2);
          body = CustomMessageText(text: 'Ma’lumotlar yangilandi'.tr, color: color ?? Colors.white, fontSize: 14.sp, isText: false);
        } else if (mode == LoadStatus.failed) {
          //body = TextSmall(text: 'Ehhh nimadir xato ketdi'.tr, fontSize: 14.sp, color: color ?? Colors.white, fontWeight: FontWeight.w400);
          body = CustomMessageText(text: 'Ehhh nimadir xato ketdi'.tr, color: color ?? Colors.white, fontSize: 14.sp, isText: true);
        } else if (mode == LoadStatus.canLoading) {
          body = const SizedBox();
        } else {
          //body = TextSmall(text: 'Ma’lumotlar yangilandi'.tr, fontSize: 14.sp, color: color ?? Colors.white, fontWeight: FontWeight.w400);
          body = CustomMessageText(text: 'Ma’lumotlar yangilandi'.tr, color: color ?? Colors.white, fontSize: 14.sp, isText: true);
        }
        return SizedBox(height: 60.sp, child: Center(child: body));
      }
    );
  }
}

class CustomMessageText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final bool isText;

  const CustomMessageText({super.key, required this.text, required this.color, required this.fontSize, required this.isText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15.r)
      ),
      child: isText ? TextSmall(
        text: text,
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.w400
      ) : SizedBox(width: 20.sp, height: 30.sp, child: const CircularProgressIndicator(color: Colors.blue, backgroundColor: Colors.white, strokeWidth: 2))
    );
  }

}