import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tarix/companents/filds/text_small.dart';
import 'package:tarix/companents/settings/instrument_components.dart';
import 'package:tarix/resource/app_colors.dart';
import 'package:tarix/sample/pages/settings/app_info_page.dart';
import 'package:tarix/sample/pages/settings/payment_history_page.dart';
import 'package:tarix/sample/pages/settings/question_info_page.dart';
import '../companents/settings/acc_item.dart';
import '../controller/get_controller.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 15.w),
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
                    if (_getController.meModel.value.data?.photo != null && _getController.meModel.value.data?.photo != '' && _getController.meModel.value.data?.photo != 'null')
                      Container(
                          width: 125.w,
                          height: 125.h,
                          margin: EdgeInsets.only(bottom: 10.h),
                          decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: NetworkImage(_getController.meModel.value.data?.photo ?? 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png')))
                      )
                    else
                      Container(
                          width: 125.w,
                          height: 125.h,
                          margin: EdgeInsets.only(bottom: 10.h),
                          decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.grey6),
                          child: Center(child: TextSmall(text: _getController.meModel.value.data!.fullName.toString().substring(0, 1).toUpperCase(), color: AppColors.black, fontSize: 50.sp, fontWeight: FontWeight.bold))
                      ),
                    TextSmall(text: _getController.meModel.value.data!.fullName.toString(), color: AppColors.black, fontSize: 24.sp, fontWeight: FontWeight.bold),
                    TextSmall(text: _getController.meModel.value.data?.email ?? '', color: AppColors.grey3, fontSize: 18.sp),
                  ]
                )
            )),
            SizedBox(height: 20.h),
            Divider(color: AppColors.grey6, height: 1.h),
            SizedBox(height: 10.h),
            AccItem(title: 'Dastur haqida', icon: FluentIcons.info_24_regular, subTitle: '', onTaps: () => Get.to(() => AppInfoPage())),
            AccItem(title: 'Test natijalari', icon: FluentIcons.document_bullet_list_24_regular, subTitle: '', onTaps: () => Get.to(() => QuestionInfoPage())),
            AccItem(title: 'To’lovlar tarixi', icon: FluentIcons.credit_card_clock_24_regular, subTitle: '', onTaps: () => Get.to(() => PaymentHistoryPage())),
            AccItem(title: 'Tilni o‘zgartirish', icon: FluentIcons.globe_24_regular, subTitle: 'uz_UZ' == _getController.getLocale() ? 'O‘zbekcha' : 'oz_OZ' == _getController.getLocale() ? 'Ўзбекча' : 'Русский', onTaps: () => InstrumentComponents().languageDialog(context)),
            AccItem(title: 'Ilovadan chiqish', icon: FluentIcons.arrow_exit_20_filled, color: AppColors.red, subTitle: '', onTaps: () => InstrumentComponents().logOutDialog(context)),
          ]
      )
    );
  }
}