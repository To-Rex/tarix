import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../bottombar/home_page.dart';
import '../bottombar/settings_page.dart';
import '../companents/settings/instrument_components.dart';
import '../models/app_info_model.dart';
import '../models/grade_model.dart';
import '../models/me_model.dart';
import '../models/payment_history.dart';
import '../models/presentation_model.dart';
import '../models/question_model.dart';
import '../models/quiz_model.dart';
import '../models/subject_model.dart';
import '../sample/auth/login_page.dart';

class GetController extends GetxController {
  var height = 0.0.obs;
  var width = 0.0.obs;
  RxInt index = 0.obs;
  RxString name = 'Dilshodjon'.obs;
  RxString firstName = 'Haydarov'.obs;
  Timer? _timerTap;
  var widgetOptions = <Widget>[];
  final countdownDuration = const Duration(minutes: 1, seconds: 59).obs;
  final currentQuestionIndex = 0.obs;
  // Tanlangan javob
  final selectedAnswer = ''.obs;
  // Savollar ro'yxati (masalan, API dan keladi)
  final questions = <QuestionModel>[].obs;
  // Taymer
  final timerText = '59:11'.obs;
  int seconds = 3551; // 59 daqiqa 11 sekund
  late Timer _timer;

  final RefreshController refreshController = RefreshController(initialRefresh: false);
  final RefreshController refreshDetailController = RefreshController(initialRefresh: false);
  final RefreshController refreshSubCatController = RefreshController(initialRefresh: false);
  final RefreshController refreshClassesController = RefreshController(initialRefresh: false);
  final RefreshController refreshPresentationController = RefreshController(initialRefresh: false);
  final RefreshController refreshQuestionsController = RefreshController(initialRefresh: false);
  final RefreshController refreshPaymentHistoryController = RefreshController(initialRefresh: false);

  final ScrollController  scrollController = ScrollController();
  final ScrollController  scrollDetailController = ScrollController();
  final ScrollController  scrollCatController = ScrollController();
  final ScrollController  scrollClassesController = ScrollController();
  final ScrollController  scrollPresentationController = ScrollController();
  final ScrollController  scrollQuestionsController = ScrollController();
  final ScrollController  scrollPaymentHistoryController = ScrollController();

  //text editing controllers
  final TextEditingController searchQuizController = TextEditingController();

  //---------------------------------------------------------------------------------------------------------------------------------
  var meModel = MeModel().obs;
  var subjectModel = SubjectModel().obs;
  var subjectCatModel = SubjectModel().obs;
  var gradeModel = GradeModel().obs;
  var presentationModel = PresentationModel().obs;
  var quizModel = QuizModel().obs;
  var appInfoModel = AppInfoModel().obs;
  var paymentHistory = PaymentHistory().obs;

  //change Models
  void changeMeModel(MeModel model) => meModel.value = model;
  void changeSubjectModel(SubjectModel model) => subjectModel.value = model;
  void changeSubjectCatModel(SubjectModel model) => subjectCatModel.value = model;
  void changeGradeModel(GradeModel model) => gradeModel.value = model;
  void changePresentationModel(PresentationModel model) => presentationModel.value = model;
  void changeQuizModel(QuizModel model) => quizModel.value = model;
  void changeAppInfoModel(AppInfoModel model) => appInfoModel.value = model;
  void changePaymentModel(PaymentHistory model) => paymentHistory.value = model;


  //clear Models
  void clearMeModel() => meModel.value = MeModel();
  void clearSubjectModel() => subjectModel.value = SubjectModel();
  void clearSubjectCatModel() => subjectCatModel.value = SubjectModel();
  void clearGradeModel() => gradeModel.value = GradeModel();
  void clearPresentationModel() => presentationModel.value = PresentationModel();
  void clearQuizModel() => quizModel.value = QuizModel();

  //Function to get the screen size
  //---------------------------------------------------------------------------------------------------------------------------------
  @override
  void onInit() {
    super.onInit();
    // Savollarni yuklash
    questions.addAll([
      QuestionModel(
        id: '1',
        text: 'Neandertal odamining qoldiqlari ... dan topilgan.',
        options: [
          OptionModel(text: 'A. Fransiya', value: 'A', isCorrect: true),
          OptionModel(text: 'B. Avstriya', value: 'B', isCorrect: false),
          OptionModel(text: 'C. Indoneziya', value: 'C', isCorrect: false),
          OptionModel(text: 'D. Germaniya', value: 'D', isCorrect: false),
        ],
      ),
      // Qo'shimcha savollar uchun placeholder
      QuestionModel(id: '2', text: 'Savol 2', options: []),
      QuestionModel(id: '3', text: 'Savol 3', options: []),
      QuestionModel(id: '4', text: 'Savol 4', options: []),
      QuestionModel(id: '5', text: 'Savol 5', options: []),
      QuestionModel(id: '6', text: 'Savol 6', options: []),
      QuestionModel(id: '7', text: 'Savol 7', options: []),
    ]);

    // Taymerni ishga tushirish
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      seconds--;
      final minutes = seconds ~/ 60;
      final secs = seconds % 60;
      timerText.value = '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
      if (seconds == 0) {
        timer.cancel();
        finishTest();
      }
    });
  }

  void selectAnswer(String value) {
    selectedAnswer.value = value;
  }

  void nextQuestion() {
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;
      selectedAnswer.value = '';
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex.value > 0) {
      currentQuestionIndex.value--;
      selectedAnswer.value = '';
    }
  }

  void finishTest() {
    _timer.cancel();
    //InstrumentComponents().shoeToast(title, message, isError, duration)
    InstrumentComponents().shoeToast('Test yakunlandi'.tr, 'Tabriklaymiz! Siz testni yakunladingiz. Natijalar saqlandi'.tr, false, 3);
    // Natijalarni saqlash yoki boshqa sahifaga o'tish
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  GetStorage box = GetStorage();

  String get headerLanguage => language.languageCode == 'uz_UZ' ? 'uz' : language.languageCode == 'oz_OZ' ? 'oz' : language.languageCode == 'ru_RU' ? 'ru' : 'en';
  get token => box.read('token');
  void saveToken(String token) => box.write('token', token);
  void saveFcmToken(String token) => box.write('fcmToken', token);

  String getMoneyFormat(value) => value == null ? '0' : value.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]} ');

  void tapTimes(Function onTap, int sec) {
    if (_timerTap != null) stopTimerTap();
    _timerTap = Timer(Duration(seconds: sec), () {
      onTap();
      _timerTap = null;
    });
  }

  void stopTimerTap() => _timerTap!.cancel();

  Locale get language => Locale(box.read('language') ?? 'uz_UZ');
  //final List locale = [{'name':'O‘zbekcha','locale': const Locale('uz','UZ'), 'icon':'assets/images/flag_uz.png'}, {'name':'Русский','locale': const Locale('ru','RU'),'icon':'assets/images/flag_ru.png'}, {'name':'English','locale': const Locale('en','US'), 'icon':'assets/images/flag_en.png'}].obs;
  final List locale = [{'name':'O‘zbekcha','locale': const Locale('uz','UZ'), 'icon':'assets/images/flag_uz.png'}, {'name':'Русский','locale': const Locale('ru','RU'),'icon':'assets/images/flag_ru.png'}].obs;

  getLocale () {
    if (Get.locale != null) {
      return Get.locale.toString();
    } else {
      return 'uz_UZ';
    }
  }

  void setHeightWidth(BuildContext context) {
    height.value = MediaQuery.of(context).size.height;
    width.value = MediaQuery.of(context).size.width;
  }

  void saveLanguage(Locale locale) {
    debugPrint(locale.languageCode.toString());
    box.write('language', '${locale.languageCode}_${locale.countryCode}');
    Get.updateLocale(locale);
  }

  void changeIndex(int value) => index.value = value;

  void changeWidgetOptions() {
    widgetOptions.add(HomePage());
    widgetOptions.add(SettingsPage());
  }

  void startDeleteCountdown() {
    countdownDuration.value = const Duration(seconds: 5); // 5 soniyadan boshlanadi
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdownDuration.value.inSeconds == 0) {
        timer.cancel();
      } else {
        countdownDuration.value = Duration(seconds: countdownDuration.value.inSeconds - 1);
      }
    });
  }

  Future<void> signOut() async {
    try {

      box.remove('token');
      box.remove('fcmToken');
      // Google Sign-In dan chiqish
      await GoogleSignIn().signOut();
      // Firebase Auth dan chiqish
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => LoginPage(), transition: Transition.fadeIn);
      print('Foydalanuvchi hisobdan chiqdi');
    } catch (e) {
      print('Chiqishda xato: $e');
    }
  }


}