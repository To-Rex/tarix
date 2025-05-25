import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tarix/controller/api_controller.dart';
import 'package:tarix/controller/get_controller.dart';
import '../../../companents/fields/search_item.dart';
import '../../../companents/filds/text_small.dart';
import '../../../companents/home/quiz_item.dart';
import '../../../companents/refresh_component.dart';
import '../../../resource/app_colors.dart';

class QuestionsPage extends StatelessWidget {
  final String title;
  final String sId;
  QuestionsPage({super.key, required this.title, required this.sId});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    _getController.clearQuizModel();
    ApiController().getQuiz(sId);
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(backgroundColor: AppColors.white, foregroundColor: AppColors.black, title: TextSmall(text: '$title ${'Savollar'.tr}', color: AppColors.black,fontSize: 20.sp, fontWeight: FontWeight.w500), centerTitle: false),
        body: RefreshComponent(
            color: AppColors.black,
            scrollController: _getController.scrollQuestionsController,
            refreshController: _getController.refreshQuestionsController,
            enablePullUp: false,
            physics: const ClampingScrollPhysics(),
            onRefresh: () async {
              _getController.clearQuizModel();
              ApiController().getQuiz(sId).then((value){
                _getController.refreshQuestionsController.refreshCompleted();
                _getController.refreshQuestionsController.loadComplete();
              });
            },
            child: Column(
              children: [
                SearchItem(
                  onChanged: (value) {
                    ApiController().getQuiz(sId);
                  }
                ),
                Obx(() => _getController.quizModel.value.data != null
                    ? _getController.quizModel.value.data!.data!.isNotEmpty
                    ? ListView.builder(
                  itemCount: (_getController.quizModel.value.data?.data?.length ?? 0) + (_getController.quizModel.value.data?.quizInfo?.paid == false ? 1 : 0),
                  shrinkWrap: true,
                  padding: EdgeInsets.only(bottom: 45.h),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (index == (_getController.quizModel.value.data?.data!.length ?? 0) && _getController.quizModel.value.data?.quizInfo?.paid == false) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                        margin: EdgeInsets.only(bottom: 40.h, left: 15.w, right: 15.w, top: 18.h),
                        decoration: BoxDecoration(
                          color: AppColors.lightGreen,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(color: AppColors.grey6),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextSmall(
                              text: 'Barcha imkoniyatlardan foydalanish uchun ilovaning to‘liq versiyasini sotib oling',
                              color: AppColors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              maxLines: 300,
                            ),
                            SizedBox(height: 5.h),
                            const Divider(color: AppColors.white, thickness: 1),
                            SizedBox(height: 5.h),
                            TextSmall(
                              text: '${'To‘lov miqdori'.tr}: 70 000 ${'so‘m'.tr}',
                              color: AppColors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              maxLines: 300,
                            ),
                            SizedBox(height: 10.h),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.lightGreen2,
                                elevation: 0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                              ),
                              onPressed: () {print('clicked button to pay');},
                              child: TextSmall(text: 'To‘lov qilish', color: AppColors.white, fontSize: 18.sp, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      );
                    }
                    // Quiz items for other indices
                    final dataIndex = index ;
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: QuizItem(
                        sId: _getController.quizModel.value.data!.data![dataIndex].sId.toString(),
                        index: dataIndex,
                        question: _getController.quizModel.value.data!.data![dataIndex].question.toString(),
                        answer: _getController.quizModel.value.data!.data![dataIndex].answer.toString(),
                      ),
                    );
                  },
                )
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
                        child: Skeletonizer(child: QuizItem(
                            sId: '92nsakskqskoqs',
                            index: index,
                            question: 'Question',
                            answer: 'Answer'
                        ))
                    ))
                )
              ],
            )
        )
    );
  }
}