import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../companents/filds/text_small.dart';
import '../companents/home/home_item.dart';
import '../companents/refresh_component.dart';
import '../controllers/api_controller.dart';
import '../controllers/get_controller.dart';
import '../resource/app_colors.dart';
import '../sample/pages/home/notification_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final GetController _getController = Get.put(GetController());
  final RefreshController refreshHomeController = RefreshController(initialRefresh: false);
  final ScrollController scrollHomeController = ScrollController();

  @override
  Widget build(BuildContext context) {
    _getController.clearSubjectModel();
    final double screenWidth = ScreenUtil().screenWidth;
    final bool isTablet = screenWidth > 600;
    final bool isSmallScreen = screenWidth < 400; // Kichik ekranlar uchun (iPhone 12 Mini kabi)

    return RefreshComponent(
      color: AppColors.black,
      scrollController: scrollHomeController,
      refreshController: refreshHomeController,
      enablePullUp: false,
      physics: const AlwaysScrollableScrollPhysics(),
      onRefresh: () async {
        _getController.clearSubjectModel();
        ApiController().getSubject().then((value) {
          refreshHomeController.refreshCompleted();
          refreshHomeController.loadComplete();
        });
      },
      child: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 1.sw,
            margin: EdgeInsets.only(
              top: isTablet ? 80.h : 70.h,
              left: isSmallScreen ? 10.w : 15.w,
              right: isSmallScreen ? 10.w : 15.w,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextSmall(
                        text: '${'Salom'.tr}, ${_getController.meModel.value.data?.doc?.fullName ?? ''} 👋',
                        color: AppColors.black,
                        fontSize: isTablet ? 20.sp : (isSmallScreen ? 20.sp : 24.sp),
                        fontWeight: FontWeight.bold,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 3.h),
                      TextSmall(
                        text: 'Yangi bilimlarni o‘rganishga tayyormisiz?',
                        color: AppColors.grey3,
                        fontSize: isTablet ? 14.sp : (isSmallScreen ? 14.sp : 16.sp),
                        fontWeight: FontWeight.w600,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: isSmallScreen ? 5.w : 10.w),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      if (isTablet)
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4.r,
                          offset: Offset(0, 2.h),
                        ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(
                      FluentIcons.alert_24_regular,
                      color: AppColors.black,
                      size: isTablet ? 22.sp : (isSmallScreen ? 22.sp : 25.sp),
                    ),
                    onPressed: () => Get.to(const NotificationPage()),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 1.sw,
            margin: EdgeInsets.only(top: 18.h),
            padding: EdgeInsets.symmetric(
              vertical: isSmallScreen ? 5.w : 10.w,
              horizontal: isTablet ? 20.w : (isSmallScreen ? 10.w : 15.w),
            ),
            constraints: BoxConstraints(minHeight: Get.height - 200.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
            ),
            child: _getController.subjectModel.value.data == null
                ? GridView.builder(
              itemCount: 3,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isTablet ? 2 : 1,
                crossAxisSpacing: isTablet ? 20.w : (isSmallScreen ? 8.w : 10.w),
                mainAxisSpacing: isTablet ? 20.h : (isSmallScreen ? 8.h : 10.h),
                childAspectRatio: isTablet ? 1.3 : (isSmallScreen ? 1.0 : 1.3), // Kichik ekranlarda balandroq
              ),
              itemBuilder: (context, index) => Skeletonizer(
                child: HomeItem(
                  title: 'Salom, Dilshodjon',
                  image: '',
                  index: index,
                  sId: 'siwu898au89a',
                ),
              ),
            )
                : _getController.subjectModel.value.data!.isNotEmpty
                ? GridView.builder(
              itemCount: _getController.subjectModel.value.data!.length,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isTablet ? 2 : 1,
                crossAxisSpacing: isTablet ? 20.w : (isSmallScreen ? 8.w : 10.w),
                mainAxisSpacing: isTablet ? 20.h : (isSmallScreen ? 8.h : 10.h),
                childAspectRatio: isTablet ? 1.3 : (isSmallScreen ? 1.0 : 1.3),
              ),
              itemBuilder: (context, index) {
                if (_getController.subjectModel.value.data![index].title == null) {
                  _getController.clearSubjectModel();
                  ApiController().getSubject();
                  return Container();
                }
                return HomeItem(
                  title: _getController.subjectModel.value.data![index].title.toString(),
                  image: _getController.subjectModel.value.data![index].photo.toString(),
                  index: index,
                  sId: _getController.subjectModel.value.data![index].sId.toString(),
                );
              },
            )
                : Center(
              child: TextSmall(
                text: 'Ma’lumotlar yo’q',
                color: AppColors.black,
                fontSize: isTablet ? 14.sp : (isSmallScreen ? 14.sp : 16.sp),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      )),
    );
  }
}