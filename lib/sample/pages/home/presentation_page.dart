import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../companents/filds/text_small.dart';
import '../../../companents/home/presentation_item.dart';
import '../../../companents/refresh_component.dart';
import '../../../controllers/api_controller.dart';
import '../../../controllers/get_controller.dart';
import '../../../resource/app_colors.dart';

class PresentationPage extends StatelessWidget {
  final String title;
  final String sId;
  final String type;
  final bool isGrade;
  PresentationPage({super.key, required this.title, required this.sId, required this.type, required this.isGrade});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    _getController.clearPresentationModel();
    print('=== ${isGrade} ===');
    ApiController().getPresentation(sId, isGrade);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(surfaceTintColor: AppColors.white, backgroundColor: AppColors.white, foregroundColor: AppColors.black, title: TextSmall(text: title, color: AppColors.black, fontSize: 20.sp, fontWeight: FontWeight.w500), centerTitle: false),
      body: RefreshComponent(
        color: AppColors.black,
        scrollController: _getController.scrollPresentationController,
        refreshController: _getController.refreshPresentationController,
        enablePullUp: false,
        physics: const ClampingScrollPhysics(),
        onRefresh: () async {
          _getController.clearPresentationModel();
          ApiController().getPresentation(sId, isGrade).then((value){
            _getController.refreshPresentationController.refreshCompleted();
            _getController.refreshPresentationController.loadComplete();
          });
        },
        child: Obx(() => _getController.presentationModel.value.data != null
            ? _getController.presentationModel.value.data!.isNotEmpty
            ? ListView.builder(
            itemCount: _getController.presentationModel.value.data!.length,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              if (_getController.presentationModel.value.data![index].name == null) {
                ApiController().getPresentation(sId, isGrade);
                return Container();
              }
              return Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: PresentationItem(
                      title: _getController.presentationModel.value.data![index].name.toString(),
                      sId: _getController.presentationModel.value.data![index].sId.toString(),
                      size: _getController.presentationModel.value.data![index].size.toString(),
                      file: _getController.presentationModel.value.data![index].file.toString(),
                      mimetype: _getController.presentationModel.value.data![index].mimetype.toString(),
                      price: _getController.presentationModel.value.data![index].price.toString(),
                      isFree: _getController.presentationModel.value.data![index].isFree.toString() == 'true' ? true : false
                  )
              );
            })
            : Container(
            width: 1.sw,
            margin: const EdgeInsets.only(top: 18),
            padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 15.w),
            constraints: BoxConstraints(minHeight: Get.height - 200.h),
            decoration:  BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r))),
            alignment: Alignment.center,
            child: TextSmall(text: 'Ma’lumotlar yo’q', color: AppColors.black, fontSize: 16.sp, fontWeight: FontWeight.w500))
            : ListView.builder(
            itemCount: 10,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Skeletonizer(child: PresentationItem(title: 'Title', sId: '2js829is9i02o02wi02', size: 'Size', file: '', mimetype: 'None', price: '0', isFree: true))
            ))
        )
    )
    );
  }
}