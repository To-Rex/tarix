import 'package:disposable_cached_images/disposable_cached_images.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tarix/resource/string.dart';
import 'package:tarix/sample/splash_screen.dart';
import 'controller/dependency.dart';
import 'controller/get_controller.dart';
import 'firebase_options.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /*FlutterNativeSplash.preserve(widgetsBinding: WidgetsFlutterBinding.ensureInitialized());
  FlutterNativeSplash.remove();*/
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.light));
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await DisposableImages.init();
  runApp(DisposableImages(MyApp()));
  try{
    DependencyInjection.init();
  } catch(e){
    debugPrint(e.toString());
  }
}


class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GetController _getController = Get.put(GetController());

  static const platform = MethodChannel('app_name_channel');

  Future<void> setAppName(String name) async {
    try {
      await platform.invokeMethod('setAppName', {'name': name});
    } catch (e) {
      print('Xato: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    _getController.setHeightWidth(context);
    setAppName('ooookkkkk');
    return ScreenUtilInit(
        designSize: Size(
            _getController.width.value, _getController.height.value),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Hicom',
              theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Schyler'),
              translations: LocaleString(),
              locale: GetController().language,
              home: SplashScreen()
          );
        }
    );
  }
}