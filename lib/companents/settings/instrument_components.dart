import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controllers/api_controller.dart';
import '../../controllers/get_controller.dart';
import '../../resource/app_colors.dart';
import '../../sample/auth/login_page.dart';
import '../fields/text_large.dart';
import '../filds/text_small.dart';

class InstrumentComponents {
  final GetController _getController = Get.put(GetController());

  void updateLanguage(Locale locale){Get.updateLocale(locale);_getController.saveLanguage(locale);}


  void bottomSheetAccountsDelete(BuildContext context) => Get.bottomSheet(
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
                                ApiController().deleteProfile();
                              },
                              style: ElevatedButton.styleFrom(backgroundColor: AppColors.red, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24.r))),
      enableDrag: true,
      elevation: 0,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 20,
                          offset: const Offset(0, -4)
                      )
                    ]
                ),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Drag handle
                      Container(
                          height: 4.h,
                          width: 40.w,
                          margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
                          decoration: BoxDecoration(
                              color: AppColors.grey5,
                              borderRadius: BorderRadius.circular(10.r)
                          )
                      ),
                      // Title section
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                          child: Row(
                              children: [
                                  Container(
                                      width: 42.w,
                                      height: 42.h,
                                      decoration: BoxDecoration(
                                          color: AppColors.grey8,
                                          borderRadius: BorderRadius.circular(12.r)
                                      ),
                                      child: Icon(TablerIcons.language, color: AppColors.primaryColor, size: 22.sp)
                                  ),
                                  SizedBox(width: 14.w),
                                  Expanded(
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                              TextSmall(
                                                  text: 'Tilni tanlang'.tr,
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.black,
                                              ),
                                              SizedBox(height: 2.h),
                                              TextSmall(
                                                  text: 'Ilova tilini o\'zgartiring'.tr,
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.grey3,
                                              ),
                                          ]
                                      )
                                  )
                              ]
                          )
                      ),
                      // Divider
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Divider(color: AppColors.grey7, height: 1.h, thickness: 1)
                      ),
                      SizedBox(height: 8.h),
                      // Language list
                      ...List.generate(_getController.locale.length, (index) {
                        final isSelected = _getController.locale[index]['locale'].toString() == _getController.language.toString();
                        return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                            child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                    borderRadius: BorderRadius.circular(16.r),
                                    overlayColor: WidgetStateProperty.all(AppColors.primaryColor.withValues(alpha: 0.06)),
                                    onTap: () {
                                      updateLanguage(_getController.locale[index]['locale']);
                                      ApiController().getSubject();
                                      Get.back();
                                    },
                                    child: AnimatedContainer(
                                        duration: const Duration(milliseconds: 250),
                                        curve: Curves.easeInOut,
                                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                                        decoration: BoxDecoration(
                                            color: isSelected ? AppColors.primaryColor.withValues(alpha: 0.07) : AppColors.grey8.withValues(alpha: 0.5),
                                            borderRadius: BorderRadius.circular(16.r),
                                            border: Border.all(
                                                color: isSelected ? AppColors.primaryColor.withValues(alpha: 0.3) : Colors.transparent,
                                                width: 1.5.w
                                            )
                                        ),
                                        child: Row(
                                            children: [
                                              // Flag with container
                                              Container(
                                                  width: 58.w,
                                                  height: 48.h,
                                                  padding: EdgeInsets.all(10.r),
                                                  decoration: BoxDecoration(
                                                      color: isSelected ? AppColors.white : AppColors.grey7,
                                                      borderRadius: BorderRadius.circular(12.r),
                                                      boxShadow: isSelected
                                                          ? [BoxShadow(color: AppColors.primaryColor.withValues(alpha: 0.15), blurRadius: 8, offset: const Offset(0, 2))]
                                                          : []
                                                  ),
                                                  child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(4.r),
                                                      child: Image.asset(_getController.locale[index]['icon'], fit: BoxFit.cover)
                                                  )
                                              ),
                                              SizedBox(width: 16.w),
                                              // Language name
                                              Expanded(
                                                  child: TextSmall(
                                                      text: _getController.locale[index]['name'],
                                                      fontSize: 16.sp,
                                                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                                      color: isSelected ? AppColors.primaryColor : AppColors.darkGrey,
                                                  )
                                              ),
                                              // Check indicator
                                              AnimatedContainer(
                                                  duration: const Duration(milliseconds: 250),
                                                  width: isSelected ? 28.w : 0,
                                                  height: isSelected ? 28.h : 0,
                                                  decoration: BoxDecoration(
                                                      color: AppColors.primaryColor,
                                                      shape: BoxShape.circle,
                                                      boxShadow: isSelected
                                                          ? [BoxShadow(color: AppColors.primaryColor.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 2))]
                                                          : []
                                                  ),
                                                  child: isSelected
                                                      ? Icon(TablerIcons.check, color: AppColors.white, size: 16.sp)
                                                      : const SizedBox.shrink()
                                              )
                                            ]
                                        )
                                    )
                                )
                            )
                        );
                      }),
                      SizedBox(height: 16.h),
                      // Bottom safe area
                      SizedBox(height: MediaQuery.of(context).padding.bottom > 0 ? 8.h : 0),
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
                  padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 50.h),
                  width: double.infinity,
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
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
                          decoration: const BoxDecoration(gradient: LinearGradient(colors: [AppColors.white, AppColors.black, AppColors.white], stops: [0.0, 0.5, 1.0], begin: Alignment.centerLeft, end: Alignment.centerRight))
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
                              text: '${_getController.getMoneyFormat(_getController.meModel.value.data!.appPrice.toString())} ${'so‘m'.tr}',
                              color: AppColors.primaryColor,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              maxLines: 300,
                            ),
                          ],
                        ),
                        SizedBox(height: 30.h),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(Get.width * 0.93, 50.h),
                              backgroundColor: AppColors.primaryColor,
                              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r))
                          ),
                          child: TextSmall(text: 'To‘lash'.tr, color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 18.sp),
                          onPressed: () async {
                            Get.back();
                            print('clicked button to pay');
                            final String merchantId = "68aebc7dd0369401e31bb756";
                            final String email = _getController.meModel.value.data?.doc?.email ?? "";
                            final int amount = _getController.meModel.value.data!.appPrice! * 100;
                            final String raw = "m=$merchantId;ac.email=$email;a=$amount";
                            print(raw);
                            final String encoded = base64Encode(utf8.encode(raw));
                            final Uri url = Uri.parse("https://checkout.paycom.uz/$encoded");
                            print(url.toString());

                            try {
                              await launchUrl(url, mode: LaunchMode.externalApplication);
                              print("✅ URL muvaffaqiyatli ochildi");
                            } catch (e) {
                              print("❌ URL ochishda xatolik: $e");
                              // Foydalanuvchiga xabar ko'rsating, masalan:
                              shoeToast('Xatolik'.tr, 'To\'lov sahifasini ochib bo\'lmadi. Brauzerni tekshiring.'.tr, true, 3);
                            }
                          }
                        ),
                      ]
                    )
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