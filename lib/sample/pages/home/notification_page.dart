import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../companents/filds/text_small.dart';
import '../../../resource/app_colors.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenUtil().screenWidth;
    final bool isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: AppColors.grey8,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        foregroundColor: AppColors.black,
        title: TextSmall(
          text: 'Bildirishnomalar',
          color: AppColors.black,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: _buildEmptyState(isTablet),
    );
  }

  Widget _buildEmptyState(bool isTablet) {
    return Container(
      width: 1.sw,
      constraints: BoxConstraints(minHeight: Get.height - 150.h),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: isTablet ? 120.w : 100.w,
            height: isTablet ? 120.w : 100.w,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor.withValues(alpha: 0.3),
                  blurRadius: 20.r,
                  offset: Offset(0, 8.h),
                ),
              ],
            ),
            child: Icon(
              FluentIcons.alert_24_regular,
              color: AppColors.white,
              size: isTablet ? 48.sp : 40.sp,
            ),
          ),
          SizedBox(height: 24.h),
          TextSmall(
            text: 'Bildirishnomalar yo\'q',
            color: AppColors.black,
            fontSize: isTablet ? 20.sp : 18.sp,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: TextSmall(
              text: 'notification_empty_desc',
              color: AppColors.grey3,
              fontSize: isTablet ? 15.sp : 14.sp,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
              maxLines: 3,
            ),
          ),
          SizedBox(height: 32.h),
          Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor.withValues(alpha: 0.25),
                  blurRadius: 12.r,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12.r),
                onTap: () => Get.back(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 14.h),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(FluentIcons.arrow_left_24_regular, color: AppColors.white, size: 18.sp),
                      SizedBox(width: 8.w),
                      TextSmall(
                        text: 'Orqaga qaytish',
                        color: AppColors.white,
                        fontSize: isTablet ? 16.sp : 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
