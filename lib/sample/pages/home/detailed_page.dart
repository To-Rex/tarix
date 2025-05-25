import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tarix/companents/filds/text_small.dart';
import 'package:tarix/controller/api_controller.dart';
import '../../../companents/home/subject_item.dart';
import '../../../companents/refresh_component.dart';
import '../../../controller/get_controller.dart';
import '../../../resource/app_colors.dart';

class DetailedPage extends StatelessWidget {
  final String title;
  final String sId;
  DetailedPage({super.key, required this.sId, required this.title});


  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    _getController.clearSubjectCatModel();
    ApiController().getSubjectCategory(sId);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        title: TextSmall(text: title, color: AppColors.black, fontSize: 20.sp, fontWeight: FontWeight.w500),
        centerTitle: false,
      ),
      body: RefreshComponent(
          color: AppColors.black,
          scrollController: _getController.scrollDetailController,
          refreshController: _getController.refreshDetailController,
          enablePullUp: false,
          physics: const ClampingScrollPhysics(),
          onRefresh: () async {
            _getController.clearSubjectCatModel();
            ApiController().getSubjectCategory(sId).then((value){
              _getController.refreshDetailController.refreshCompleted();
              _getController.refreshDetailController.loadComplete();
            });
          },
          child: Obx(() => _getController.subjectCatModel.value.data != null
              ? _getController.subjectCatModel.value.data!.isNotEmpty
              ? ListView.builder(
              itemCount: _getController.subjectCatModel.value.data!.length,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: SubjectItem(
                      image: _getController.subjectCatModel.value.data![index].photo.toString(),
                      title: _getController.subjectCatModel.value.data![index].title.toString(),
                      index: index, sId: _getController.subjectCatModel.value.data![index].sId.toString(),
                      type: _getController.subjectCatModel.value.data![index].type.toString(),
                      withGrade: _getController.subjectCatModel.value.data![index].withGrade ?? false,
                      subtitle: _getController.subjectCatModel.value.data![index].subtitle.toString()
                  )))
              : Container(
              width: 1.sw,
              margin: const EdgeInsets.only(top: 18),
              padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 15.w),
              constraints: BoxConstraints(minHeight: Get.height - 200.h),
              decoration:  BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r))),
              alignment: Alignment.center,
              child: TextSmall(text: 'Ma’lumotlar yo’q', color: AppColors.black, fontSize: 16.sp, fontWeight: FontWeight.w500))
              : ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Skeletonizer(child: SubjectItem(
                      image: '', title: '', index: index, sId: '', type: '', withGrade: false, subtitle: '')
                  )))
          )
      )
    );
  }
}