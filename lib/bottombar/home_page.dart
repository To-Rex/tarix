import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tarix/controller/api_controller.dart';
import 'package:tarix/resource/app_colors.dart';
import 'package:tarix/sample/pages/home/notification_page.dart';
import '../companents/filds/text_small.dart';
import '../companents/home/home_item.dart';
import '../companents/refresh_component.dart';
import '../controller/get_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final GetController _getController = Get.put(GetController());
  final RefreshController refreshHomeController = RefreshController(initialRefresh: false);
  final ScrollController  scrollHomeController = ScrollController();

  @override
  Widget build(BuildContext context) {
    _getController.clearSubjectModel();
    return RefreshComponent(
        color: AppColors.black,
        scrollController: scrollHomeController,
        refreshController: refreshHomeController,
        enablePullUp: false,
        physics: const ClampingScrollPhysics(),
        onRefresh: () async {
          _getController.clearSubjectModel();
          ApiController().getSubject().then((value){
            refreshHomeController.refreshCompleted();
            refreshHomeController.loadComplete();
          });
        },
        child: Obx(() => Column(
            children: [
              Container(
                  width: 1.sw,
                  margin: EdgeInsets.only(top: 70.h, left: 15.w, right: 15.w),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextSmall(text: '${'Salom'.tr}, ${_getController.meModel.value.data?.fullName} 👋', color: AppColors.black, fontSize: 24.sp, fontWeight: FontWeight.bold),
                                  SizedBox(height: 3.h),
                                  TextSmall(text: 'Yangi bilimlarni o‘rganishga tayyormisiz?', color: AppColors.grey3, fontSize: 16.sp, fontWeight: FontWeight.w600)
                                ]
                            )
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 10.w),
                            decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(12.r)),
                            child: IconButton(icon: Icon(FluentIcons.alert_24_regular, color: AppColors.black, size: 25.sp), onPressed: () => Get.to(const NotificationPage()))
                        )
                      ]
                  )
              ),
              _getController.subjectModel.value.data == null
                  ? Container(
                  width: 1.sw,
                  margin: const EdgeInsets.only(top: 18),
                  padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 15.w),
                  constraints: BoxConstraints(minHeight: Get.height - 200.h),
                  decoration:  BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r))),
                  child: SingleChildScrollView(
                      child: ListView.builder(
                          itemCount: 3,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => Skeletonizer(child: HomeItem(title: 'Salom, Dilshodjon', image: '', index: index, sId: 'siwu898au89a'))
                      )
                  ))
                  : _getController.subjectModel.value.data!.isNotEmpty
                  ? Container(
                  width: 1.sw,
                  margin: const EdgeInsets.only(top: 18),
                  padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 15.w),
                  constraints: BoxConstraints(minHeight: Get.height - 200.h),
                  decoration:  BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r))),
                  child: SingleChildScrollView(
                      child: ListView.builder(
                          itemCount: _getController.subjectModel.value.data!.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            if (_getController.subjectModel.value.data![index].title == null) {
                              _getController.clearSubjectModel();
                              ApiController().getSubject();
                              return Container();
                            }
                            return HomeItem(title: _getController.subjectModel.value.data![index].title.toString(), image: _getController.subjectModel.value.data![index].photo.toString(), index: index, sId: _getController.subjectModel.value.data![index].sId.toString());
                          })
                  )
              )
                  : Container(
                  width: 1.sw,
                  margin: const EdgeInsets.only(top: 18),
                  padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 15.w),
                  constraints: BoxConstraints(minHeight: Get.height - 200.h),
                  decoration:  BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r))),
                  alignment: Alignment.center,
                  child: TextSmall(text: 'Ma’lumotlar yo’q', color: AppColors.black, fontSize: 16.sp, fontWeight: FontWeight.w500))
            ]
        ))
    );
  }
}