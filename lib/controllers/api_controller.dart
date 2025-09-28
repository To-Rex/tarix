import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../models/app_info_model.dart';
import '../models/grade_model.dart';
import '../models/me_model.dart';
import '../models/presentation_model.dart';
import '../models/quiz_model.dart';
import '../models/subject_model.dart';
import '../sample/pages/error_page.dart';
import '../sample/sample_page.dart';
import 'get_controller.dart';

class ApiController extends GetxController {
  final GetController _getController = Get.put(GetController());

  final  baseUrl = 'https://history.enko.uz/api';

  //return header function
  Map<String, String> headersBearer() {
    print('=====================================================Bearer ${_getController.token}');
    print(_getController.headerLanguage);
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_getController.token}',
      'Accept-Language': _getController.headerLanguage
    };
  }

  Map<String, String> headerBearer() => {'Authorization': 'Bearer ${_getController.token}'};

  Map<String, String> header() => {'Content': 'application/json'};

  Map<String, String> multipartHeaderBearer() {
    return {
      'Authorization': 'Bearer ${_getController.token}',
      'Content-Type': 'multipart/form-data',
      'Lang': _getController.headerLanguage
    };
  }

  Future<void> downloadFile(BuildContext context, String url, String fileName) async {
    try {
      String downloadsPath = '/storage/emulated/0/Download'; // Android uchun
      if (Platform.isIOS) {
        downloadsPath = (await getApplicationDocumentsDirectory()).path; // iOS uchun vaqtinchalik papka
      }
      String savePath = '$downloadsPath/$fileName';
      Dio dio = Dio();
      await dio.download(url, savePath, onReceiveProgress: (received, total) {
        if (total != -1) {
          print('Downloading: ${(received / total * 100).toStringAsFixed(0)}%');
        }
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Fayl yuklab olindi: $savePath')),);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Yuklashda xatolik yuz berdi: $e')),);
    }
  }

  //App info
  Future<void> appInfo() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/mobile/about'), headers: headersBearer());
      debugPrint(response.body);
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        debugPrint(data.toString());
        _getController.changeAppInfoModel(AppInfoModel.fromJson(data));
      } else {
        print('=====================================================Xa otam nima bo`lyapti');
        Get.snackbar('Xatolik', 'Email yoki parol xato', snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print(e);
    }
  }

  //Auth
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // Registratsiya
  Future<void> login(String email, String fullName, String photo, String googleId) async {
    print('=====================================================suuuu');
    print(email);
    print(fullName);
    print(photo);
    print(googleId);
    try {
      final response = await http.post(Uri.parse('$baseUrl/mobile/auth/login'), headers: header(), body: {'email': email, 'full_name': fullName, 'photo': photo, 'google_id': googleId});
      debugPrint(response.body);
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        debugPrint(data.toString());
        _getController.saveToken(data['data']['token']);
        getMe();
      } else {
        print('=====================================================Xa otam nima bo`lyapti');
        Get.snackbar('Xatolik', 'Email yoki parol xato', snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> loginApple(String email, String fullName, String photo, String appleId, String appleIdentityToken) async {
    print('=====================================================suuuu');
    print(email);
    print(fullName);
    print(photo);
    print(appleId);
    try {
      final response = await http.post(Uri.parse('$baseUrl/mobile/auth/login'), headers: header(), body: {
        'email': email,
        'full_name': fullName,
        'photo': photo,
        'apple_id': appleId,
        'apple_identity_token': appleIdentityToken
      });
      debugPrint(response.body);
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        debugPrint(data.toString());
        _getController.saveToken(data['data']['token']);
        getMe();
      } else {
        print('=====================================================Xa otam nima bo`lyapti');
        Get.snackbar('Xatolik', 'Email yoki parol xato', snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getMe() async {

    try {
      final response = await http.get(Uri.parse('$baseUrl/mobile/auth/me'), headers: headersBearer());
      debugPrint(response.body);
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        debugPrint(data.toString());
        _getController.changeMeModel(MeModel.fromJson(data));
        getSubject();
        Get.offAll(() => SamplePage());
      } else {
        Get.offAll(() =>  const ErrorPage());
        print('=====================================================suuu Xa otam nima bo`lyapti');
      }
    } catch (e) {
      Get.offAll(() =>  const ErrorPage());
      print(e);
    }
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Subject
  Future<void> getSubject() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/mobile/subject/list'), headers: headersBearer());
      debugPrint(response.body);
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        debugPrint(data.toString());
        _getController.changeSubjectModel(SubjectModel.fromJson(data));
      } else {
        print('=====================================================Xa otam nima bo`lyapti');
        Get.snackbar('Xatolik', 'Email yoki parol xato', snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getSubjectCategory(String subjectId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/mobile/subject-category/list?subject=$subjectId'), headers: headersBearer());
      debugPrint(response.body);
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        debugPrint(data.toString());
        _getController.changeSubjectCatModel(SubjectModel.fromJson(data));
      } else {
        print('=====================================================Xa otam nima bo`lyapti');
        Get.snackbar('Xatolik', 'Email yoki parol xato', snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getGrade(String sId, String type) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/mobile/grade/list?subject_category=$sId'), headers: headersBearer());
      debugPrint(response.body);
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        debugPrint(data.toString());
        _getController.changeGradeModel(GradeModel.fromJson(data));
        if (type == 'presentation') {
          print('=====================================================suuuu');
          _getController.changePresentationModel(
              PresentationModel.fromJson(data));
        }
      } else {
        print('=====================================================Xa otam nima bo`lyapti');
        Get.snackbar('Xatolik', 'Email yoki parol xato', snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getPresentation(String subjectCategory, bool isGrade) async {
    try {
      //final response = await http.get(Uri.parse('$baseUrl/mobile/presentation/list?subject_category=$subjectCategory'), headers: headersBearer());
      final response = await http.get(
          Uri.parse('$baseUrl/mobile/presentation/list?${isGrade ? 'grade=$subjectCategory' : 'subject_category=$subjectCategory'}'),
          headers: headersBearer());
      debugPrint(response.body);
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        debugPrint(data.toString());
        _getController.changePresentationModel(PresentationModel.fromJson(data));
      } else {
        print('=====================================================Xa otam nima bo`lyapti');
        Get.snackbar('Xatolik', 'Email yoki parol xato', snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print(e);
    }
  }

  //{{base_url}}/mobile/quiz/list?grade=67854e44587c8d0a611f520d
  Future<void> getQuiz(String grade) async {
    try {
      //https://history.enko.uz/api/mobile/quiz/list?grade=67854e44587c8d0a611f520d&search=Lojuvard
      final response = await http.get(Uri.parse('$baseUrl/mobile/quiz/list?grade=$grade${_getController.searchQuizController.text.isNotEmpty ? '&search=${_getController.searchQuizController.text}' : ''}'), headers: headersBearer());
      debugPrint('$baseUrl/mobile/quiz/list?grade=67854e44587c8d0a611f520d${_getController.searchQuizController.text.isNotEmpty ? '&search=${_getController.searchQuizController.text}' : ''}');
      debugPrint(response.body);
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        debugPrint(data.toString());
        _getController.changeQuizModel(QuizModel.fromJson(data));
      } else {
        print('=====================================================Xa otam nima bo`lyapti');
        Get.snackbar('Xatolik', 'Email yoki parol xato', snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print('suuu');
      print(e);
    }
  }
}
