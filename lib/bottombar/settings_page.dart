import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../companents/filds/text_small.dart';
import '../companents/settings/acc_item.dart';
import '../companents/settings/instrument_components.dart';
import '../controllers/get_controller.dart';
import '../resource/app_colors.dart';
import '../sample/pages/settings/app_info_page.dart';
import '../sample/pages/settings/payment_history_page.dart';
import '../sample/pages/settings/question_info_page.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: Get.height,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 70.h),
              TextSmall(text: 'Sozlamalar', color: Colors.black, fontSize: 24.sp, fontWeight: FontWeight.bold),
              SizedBox(height: 15.h),
              Obx(() => SizedBox(
                  width: 1.sw,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_getController.meModel.value.data?.doc?.photo != null && _getController.meModel.value.data?.doc?.photo != '' && _getController.meModel.value.data?.doc?.photo != 'null')
                          Container(
                              width: 125.w,
                              height: 125.h,
                              margin: EdgeInsets.only(bottom: 10.h),
                              decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(_getController.meModel.value.data?.doc?.photo ?? 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png')))
                          )
                        else
                          Container(
                              width: 125.w,
                              height: 125.h,
                              margin: EdgeInsets.only(bottom: 10.h),
                              decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.grey6),
                              child: Center(child: TextSmall(text: (_getController.meModel.value.data?.doc?.fullName?.isNotEmpty ?? false) ? _getController.meModel.value.data!.doc!.fullName![0].toUpperCase() : "?", color: AppColors.black, fontSize: 50.sp, fontWeight: FontWeight.bold))
                          ),
                        TextSmall(text: (_getController.meModel.value.data?.doc?.fullName?.isNotEmpty ?? false) ? _getController.meModel.value.data!.doc!.fullName! : 'unknown', color: AppColors.black, fontSize: 24.sp, fontWeight: FontWeight.bold),
                        TextSmall(text: _getController.meModel.value.data?.doc?.email ?? '', color: AppColors.grey3, fontSize: 18.sp),
                      ]
                  )
              )),
              SizedBox(height: 20.h),
              Divider(color: AppColors.grey6, height: 1.h),
              SizedBox(height: 10.h),
              if(_getController.meModel.value.data?.doc?.paid == false)
                AccItem(title: 'To’lov qilish', icon: FluentIcons.wallet_credit_card_24_regular, subTitle: '', onTaps: () => InstrumentComponents().bottomSheetPayment()),
              AccItem(title: 'Dastur haqida', icon: FluentIcons.info_24_regular, subTitle: '', onTaps: () => Get.to(() => AppInfoPage())),
              AccItem(title: 'Test natijalari', icon: FluentIcons.document_bullet_list_24_regular, subTitle: '', onTaps: () => Get.to(() => QuestionInfoPage())),
              AccItem(title: 'To’lovlar tarixi', icon: FluentIcons.credit_card_clock_24_regular, subTitle: '', onTaps: () => Get.to(() => PaymentHistoryPage())),
              AccItem(title: 'Tilni o‘zgartirish', icon: FluentIcons.globe_24_regular, subTitle: 'uz_UZ' == _getController.getLocale() ? 'O‘zbekcha' : 'oz_OZ' == _getController.getLocale() ? 'Ўзбекча' : 'Русский', onTaps: () => InstrumentComponents().languageDialog(context)),
              Container(
                  width: 1.sw,
                  margin: EdgeInsets.only(top: 10.h, bottom: 150.h),
                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r), border: Border.all(color: AppColors.grey6)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AccItem(title: 'Ilovadan chiqish', icon: FluentIcons.arrow_exit_20_filled, color: AppColors.grey3, subTitle: '', onTaps: () => InstrumentComponents().logOutDialog(context)),
                        SizedBox(height: 5.h),
                        Divider(color: AppColors.grey6, height: 1.h),
                        SizedBox(height: 5.h),
                        AccItem(title: 'Hisobni o‘chirish', icon: FluentIcons.delete_24_regular, color: AppColors.red, subTitle: '', onTaps: () {_getController.startDeleteCountdown();InstrumentComponents().bottomSheetAccountsDelete(context);})
                      ]
                  )
              )
            ]
        )
      )
    );
  }
}