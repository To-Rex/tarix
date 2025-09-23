import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import '../../controllers/api_controller.dart';
import '../../controllers/get_controller.dart';
import '../../resource/app_colors.dart';
import '../../sample/auth/login_page.dart';
import '../fields/text_large.dart';
import '../filds/text_small.dart';

class InstrumentComponents {
  final GetController _getController = Get.put(GetController());

  updateLanguage(Locale locale){Get.updateLocale(locale);_getController.saveLanguage(locale);}


  bottomSheetAccountsDelete(BuildContext context) => Get.bottomSheet(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
      enableDrag: false,
      isScrollControlled: false,
      backgroundColor: Theme.of(context).colorScheme.surface,
      StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
                decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0))),
                width: Get.width,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppBar(
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
                          title: TextLarge(text: 'Hisobni o‘chirish'.tr, color: AppColors.black, fontWeight: FontWeight.w400),
                          centerTitle: false,
                          backgroundColor: Theme.of(context).colorScheme.surface,
                          elevation: 0,
                          leadingWidth: 0,
                          leading: Container(),
                          actions: [
                            IconButton(onPressed: () => Get.back(), icon: Icon(TablerIcons.x, color: Theme.of(context).colorScheme.onSurface, size: Theme.of(context).buttonTheme.height))
                          ]
                      ),
                      SizedBox(height: Get.height * 0.02),
                      Container(
                          padding: EdgeInsets.only(left: Get.width * 0.035, right: Get.width * 0.035),
                          width: Get.width,
                          child: TextSmall(text: 'delete log', color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w400,maxLines: 10)),
                      SizedBox(height: Get.height * 0.04),
                      Container(
                          padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
                          child: Obx(() => _getController.countdownDuration.value.inSeconds == 0
                              ? ElevatedButton(
                              onPressed: () async {
                                //ApiController().deleteProfile();
                              },
                              style: ElevatedButton.styleFrom(backgroundColor: AppColors.secondaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                              child:const Center(child: TextSmall(text: 'O‘chirishni tasdiqlang', color: AppColors.white, fontWeight: FontWeight.w400))
                          )
                              : ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(backgroundColor: AppColors.grey, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                              child: Center(child: TextSmall(text: '${'O‘chirishni tasdiqlang'.tr} (${(_getController.countdownDuration.value.inSeconds % 60).toString()})', color: AppColors.white, fontWeight: FontWeight.w400)))
                          )
                      )
                    ]
                )
            );
          }
      )
  );

  void logOutDialog(BuildContext context) => Get.defaultDialog(
      backgroundColor: AppColors.white,
      barrierDismissible: false,
      titlePadding: EdgeInsets.only(top: 30.h, left: 10.w, right: 10.w),
      contentPadding: EdgeInsets.only(top: 15.h, left: 15.w, right: 15.w),
      title: 'Dasturdan chiqasizmi?'.tr,
      titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp, color: AppColors.black, fontFamily: 'Schyler'),
      content: TextSmall(text: 'Dasturdan chiqqaningdan so‘ng qayta kirishingiz mumkin!'.tr, color: AppColors.grey3, maxLines: 3),
      confirm: Container(
          width: 120.w,
          height: 42.h,
          margin: EdgeInsets.only(bottom: 25.h,top: 25.h),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r), color: AppColors.red),
          child: TextButton(onPressed: () {
            Get.back();
            _getController.signOut();
            }, child: TextSmall(text: 'Chiqish'.tr, color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 15.sp))
      ),
      cancel: Container(
          width: 120.w,
          height: 42.h,
          margin: EdgeInsets.only(bottom: 25.h,top: 25.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: AppColors.white,
              border: Border.all(color: AppColors.grey, width: 1.w)
          ),
          child: TextButton(
            onPressed: () => Get.back(),
            child: TextSmall(text: 'Bekor qilish'.tr, color: AppColors.black, fontWeight: FontWeight.bold, fontSize: 15.sp)
          )
      )
  );

  void languageDialog(BuildContext context) => Get.bottomSheet(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
      enableDrag: true,
      elevation: 15,
      isScrollControlled: true, // Allows full control over height
      backgroundColor: AppColors.white,
      StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SizedBox(
                  height: Get.height * 0.4,
                  width: double.infinity,
                  child: Column(
                      children: [
                        Container(
                            height: 5.h,
                            width: 100.w,
                            margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
                            decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSurface, borderRadius: BorderRadius.circular(20.r))
                        ),
                        SizedBox(height: Get.height * 0.04),
                        Expanded(
                            child: ListView.builder(
                                itemCount: _getController.locale.length,
                                itemBuilder: (context, index){
                                  return Container(
                                      height: 60.h,
                                      width: Get.width,
                                      padding: EdgeInsets.only(left: 15.w, right: 15.w),
                                      child: Column(
                                        children: [
                                          InkWell(
                                              overlayColor: WidgetStateProperty.all(Colors.transparent),
                                              child: Column(
                                                children: [
                                                  Row(
                                                      children: [
                                                        if (_getController.locale[index]['locale'].toString() == _getController.language.toString())
                                                          const Icon(TablerIcons.circle_filled, color: AppColors.lightGreen, size: 10),
                                                        if (_getController.locale[index]['locale'].toString() == _getController.language.toString())
                                                        SizedBox(width: 10.w),
                                                        Image.asset(_getController.locale[index]['icon'], width: 33.w, height: 20.h),
                                                        SizedBox(width: 10.w),
                                                        TextSmall(
                                                            text: _getController.locale[index]['name'],
                                                            fontSize: 20.sp,
                                                            color: _getController.locale[index]['locale'].toString() == _getController.language.toString() ? AppColors.lightGreen : AppColors.black,
                                                        ),
                                                      ]
                                                  ),
                                                  SizedBox(height: 10.h)
                                                ]
                                              ),
                                              onTap: (){
                                                updateLanguage(_getController.locale[index]['locale']);
                                                ApiController().getSubject();
                                                Get.back();
                                              }
                                          )
                                        ]
                                      )
                                  );
                                }
                            )
                        )
                      ]
                  )
              );
            })
  );

  void bottomSheetPayment() => Get.bottomSheet(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
      enableDrag: true,
      elevation: 15,
      isScrollControlled: true, // Allows full control over height
      backgroundColor: AppColors.white,
      StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                  height: Get.height * 0.5,
                  padding: EdgeInsets.only(left: 15.w, right: 15.w),
                  width: double.infinity,
                  child: Column(
                      children: [
                        Container(
                            height: 5.h,
                            width: 100.w,
                            margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
                            decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSurface, borderRadius: BorderRadius.circular(20.r))
                        ),
                        //SizedBox(height: Get.height * 0.02),
                        Container(
                          width: 70.h,
                          height: 70.h,
                          margin: EdgeInsets.symmetric(vertical: 20.h),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(12.r),
                            color: AppColors.grey8,
                          ),
                          child: Container(
                            width: 55.h,
                            height: 55.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: AppColors.white,
                            ),
                            child: Icon(TablerIcons.lock_filled, color: AppColors.lightGreen, size: 40.sp),
                          )
                        ),
                        TextSmall(
                          text: 'Barcha imkoniyatlardan foydalanish uchun ilovaning to‘liq versiyasini sotib oling',
                          color: AppColors.black,
                          textAlign: TextAlign.center,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          maxLines: 300,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 20.h),
                          height: 1.h, // Matches Divider thickness
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.white, // Start with white
                                AppColors.black, // Darken in the center
                                AppColors.white, // Fade back to white
                              ],
                              stops: [0.0, 0.5, 1.0], // Control gradient transition points
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextSmall(
                              text: '${'To‘lov miqdori'.tr}:',
                              color: AppColors.black,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              maxLines: 300,
                            ),
                            SizedBox(width: 10.w),
                            TextSmall(
                              text: '70 000 ${'so‘m'.tr}',
                              color: AppColors.primaryColor,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              maxLines: 300,
                            ),
                          ],
                        ),
                        SizedBox(height: 30.h),
                        const Spacer(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(Get.width * 0.93, 50.h),
                              backgroundColor: AppColors.primaryColor,
                              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r))
                          ),
                          child: TextSmall(text: 'To‘lash'.tr, color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 18.sp),
                          onPressed: () {
                            Get.back();
                            //Get.to(() => PaymentPage());
                          },
                        ),
                        SizedBox(height: Get.height * 0.06),
                      ]
                  )
              );
            })
  );

  shoeToast(title, message, isError, duration) => Get.snackbar(
      title,
      message,
      colorText: AppColors.white,
      backgroundColor: isError ? AppColors.red : AppColors.lightGreen,
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 10,
      margin: const EdgeInsets.all(15),
      duration: Duration(seconds: duration)
  );

}