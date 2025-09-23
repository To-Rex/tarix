import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../companents/filds/text_small.dart';
import '../../../companents/home/classes_item.dart';
import '../../../companents/refresh_component.dart';
import '../../../controllers/api_controller.dart';
import '../../../controllers/get_controller.dart';
import '../../../resource/app_colors.dart';

class ClassesPage extends StatelessWidget {
  final String title;
  final String sId;
  final String type;
  ClassesPage({super.key, required this.title, required this.sId, required this.type});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    _getController.clearGradeModel();
    print('hahuhahu $sId $type');
    ApiController().getGrade(sId,type);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        title: TextSmall(text: title, color: AppColors.black,fontSize: 20.sp, fontWeight: FontWeight.w500),
        centerTitle: false,
      ),
      body: RefreshComponent(
          color: AppColors.black,
          scrollController: _getController.scrollClassesController,
          refreshController: _getController.refreshClassesController,
          enablePullUp: false,
          physics: const ClampingScrollPhysics(),
          onRefresh: () async {
            _getController.clearGradeModel();
            _getController.refreshClassesController.refreshCompleted();
            _getController.refreshClassesController.loadComplete();
            ApiController().getGrade(sId, type).then((value){
              _getController.refreshClassesController.refreshCompleted();
              _getController.refreshClassesController.loadComplete();
            });
            },
          child: Obx(() => _getController.gradeModel.value.data != null
              ? _getController.gradeModel.value.data!.isNotEmpty
              ? ListView.builder(
              itemCount: _getController.gradeModel.value.data!.length,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: ClassesItem(
                    title: _getController.gradeModel.value.data![index].title.toString(),
                    sId: _getController.gradeModel.value.data![index].sId.toString(),
                    subtitle: _getController.gradeModel.value.data![index].title.toString(),
                    type: type
                  )
              ))
              : Container(
              width: 1.sw,
              margin: const EdgeInsets.only(top: 18),
              padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 15.w),
              constraints: BoxConstraints(minHeight: Get.height - 200.h),
              decoration:  BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r))),
              alignment: Alignment.center,
              child: TextSmall(text: 'Ma’lumotlar yo’q', color: AppColors.black, fontSize: 16.sp, fontWeight: FontWeight.w500))
              : Skeletonizer(child: ListView.builder(
              itemCount: 10,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: ClassesItem(title: 'Title', sId: 'sIdkjjo00', subtitle: 'Title', type: type,)
                )
            ))
          )
      )
    );
  }
}