import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/physics_topic.dart';

class PhysicsController extends GetxController {
  var topics = <PhysicsTopic>[].obs;
  var isDarkMode = false.obs;
  var selectedLanguage = 'uz'.obs;
  var isGridView = true.obs;
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
    _loadTopics();
  }

  void _loadTheme() {
    isDarkMode.value = storage.read('isDarkMode') ?? false;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    storage.write('isDarkMode', isDarkMode.value);
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: isDarkMode.value ? const Color(0xFF1E1E1E) : Colors.white,
        statusBarIconBrightness: isDarkMode.value ? Brightness.light : Brightness.dark,
      ),
    );
  }

  void changeLanguage(String lang) {
    selectedLanguage.value = lang;
    var locale = lang == 'uz' ? const Locale('uz', 'UZ') : const Locale('en', 'US');
    Get.updateLocale(locale);
  }

  void toggleView() {
    isGridView.value = !isGridView.value;
  }

  void _loadTopics() {
    topics.assignAll([
      PhysicsTopic(
        title: "N'yutonning birinchi qonuni",
        description: "Jism harakatsiz holatda yoki tekis chiziqli harakatda bo‘ladi, agar unga tashqi kuch ta'sir qilmasa.",
        formula: "F = 0 (agar harakat o‘zgarmasa)",
        questions: [
          "Inertsiya nima?",
          "Qanday hollarda jism harakatsiz qoladi?",
          "Birinchi qonun qayerda qo‘llaniladi?",
          "Kuchning yo‘qligi nimani anglatadi?",
          "Inertsiya massaga qanday bog‘liq?",
          "Birinchi qonun misollari nimalardan iborat?",
          "Jismning harakat holati qanday o‘zgaradi?",
        ],
        category: "Mexanika",
        tests: [
          TestQuestion(
            question: "Inertsiya nima?",
            options: [
              "Jismning harakatga qarshilik ko‘rsatishi",
              "Jismning tezlanishi",
              "Jismning energiyasi",
              "Jismning og‘irligi",
            ],
            correctOptionIndex: 0,
          ),
          TestQuestion(
            question: "N'yutonning birinchi qonuni qanday nomlanadi?",
            options: [
              "Harakat qonuni",
              "Inertsiya qonuni",
              "Kuch qonuni",
              "Reaksiya qonuni",
            ],
            correctOptionIndex: 1,
          ),
          TestQuestion(
            question: "Agar jismga kuch ta’sir qilmasa, u nima qiladi?",
            options: [
              "Tezlanadi",
              "Harakatsiz qoladi yoki tekis harakat qiladi",
              "To‘xtaydi",
              "Aylana bo‘yicha harakatlanadi",
            ],
            correctOptionIndex: 1,
          ),
          TestQuestion(
            question: "Inertsiya qaysi fizikaviy kattalikka bog‘liq?",
            options: [
              "Tezlik",
              "Massa",
              "Kuch",
              "Energiya",
            ],
            correctOptionIndex: 1,
          ),
        ],
      ),
      PhysicsTopic(
        title: "N'yutonning ikkinchi qonuni",
        description: "Kuch massa va tezlanishning ko‘paytmasiga teng.",
        formula: "F = m * a",
        questions: [
          "Kuchning o‘lchov birligi nima?",
          "Tezlanish qanday aniqlanadi?",
          "Massa o‘zgarmasa, kuch qanday o‘zgaradi?",
          "Bu qonun real hayotda qayerda qo‘llaniladi?",
          "Kuch vektorial kattalikmi?",
          "Tezlanishning o‘lchov birligi nima?",
          "F = m * a formulasida nimalar berilgan?",
        ],
        category: "Mexanika",
        tests: [
          TestQuestion(
            question: "Kuchning o‘lchov birligi nima?",
            options: [
              "Joul",
              "N'yuton",
              "Vatt",
              "Amper",
            ],
            correctOptionIndex: 1,
          ),
          TestQuestion(
            question: "F = m * a formulasida 'a' nima?",
            options: [
              "Massa",
              "Kuch",
              "Tezlanish",
              "Tezlik",
            ],
            correctOptionIndex: 2,
          ),
          TestQuestion(
            question: "Agar massa 2 kg, tezlanish 5 m/s² bo‘lsa, kuch qancha?",
            options: [
              "5 N",
              "10 N",
              "7 N",
              "12 N",
            ],
            correctOptionIndex: 1,
          ),
          TestQuestion(
            question: "Kuch qanday kattalik hisoblanadi?",
            options: [
              "Skalyar",
              "Vektorial",
              "Konstanta",
              "Nisbat",
            ],
            correctOptionIndex: 1,
          ),
        ],
      ),
      PhysicsTopic(
        title: "N'yutonning uchinchi qonuni",
        description: "Har bir ta’sir kuchi uchun teng va qarama-qarshi reaksiya kuchi mavjud.",
        formula: "F₁ = -F₂",
        questions: [
          "Ta’sir va reaksiya kuchlari nima?",
          "Uchinchi qonun qanday ishlaydi?",
          "Reaksiya kuchi qayerda ko‘rinadi?",
          "Bu qonun misollari nimalar?",
          "Kuchlar qanday teng bo‘ladi?",
          "Reaksiya kuchi ta’sir kuchiga qarama-qarshimi?",
          "Raketa harakati qanday tushuntiriladi?",
        ],
        category: "Mexanika",
        tests: [
          TestQuestion(
            question: "N'yutonning uchinchi qonuni nima haqida?",
            options: [
              "Inertsiya",
              "Tezlanish",
              "Ta’sir va reaksiya",
              "Kuchning yo‘qligi",
            ],
            correctOptionIndex: 2,
          ),
          TestQuestion(
            question: "Ta’sir va reaksiya kuchlari qanday bo‘ladi?",
            options: [
              "Teng va bir yo‘nalishda",
              "Teng va qarama-qarshi",
              "Turli va bir yo‘nalishda",
              "Turli va qarama-qarshi",
            ],
            correctOptionIndex: 1,
          ),
          TestQuestion(
            question: "Raketa harakatida qaysi qonun ishlaydi?",
            options: [
              "Birinchi qonun",
              "Ikkinchi qonun",
              "Uchinchi qonun",
              "Gravitatsiya qonuni",
            ],
            correctOptionIndex: 2,
          ),
          TestQuestion(
            question: "Reaksiya kuchi qaysi jismga ta’sir qiladi?",
            options: [
              "Ta’sir kuchi ta’sir qilgan jismga",
              "Boshqa jismga",
              "Hech qaysi jismga",
              "Ikki jismga ham",
            ],
            correctOptionIndex: 1,
          ),
        ],
      ),
      PhysicsTopic(
        title: "Umumjahon tortishish qonuni",
        description: "Har ikki jism bir-biriga massa va masofaga bog‘liq kuch bilan tortiladi.",
        formula: "F = G * (m₁ * m₂) / r²",
        questions: [
          "Gravitatsiya kuchi nima?",
          "G nima va uning qiymati qancha?",
          "Masofa ikki barobar oshsa, kuch qanday o‘zgaradi?",
          "Tortishish kuchi qayerda ko‘rinadi?",
          "Yerning tortishish kuchi qanday hisoblanadi?",
          "Gravitatsiya doimiysi nima uchun kerak?",
          "Sayyoralar harakati qanday tushuntiriladi?",
        ],
        category: "Mexanika",
        tests: [
          TestQuestion(
            question: "Gravitatsiya kuchi formulasi qaysi?",
            options: [
              "F = m * a",
              "F = G * (m₁ * m₂) / r²",
              "F = k * q₁ * q₂ / r²",
              "F = m * g",
            ],
            correctOptionIndex: 1,
          ),
          TestQuestion(
            question: "Gravitatsiya doimiysi G ning o‘lchov birligi nima?",
            options: [
              "N * m² / kg²",
              "m / s²",
              "kg * m / s²",
              "J / kg",
            ],
            correctOptionIndex: 0,
          ),
          TestQuestion(
            question: "Masofa 2 barobar oshsa, tortishish kuchi qanday o‘zgaradi?",
            options: [
              "2 barobar oshadi",
              "2 barobar kamayadi",
              "4 barobar kamayadi",
              "4 barobar oshadi",
            ],
            correctOptionIndex: 2,
          ),
          TestQuestion(
            question: "Yerning tortishish tezlanishi taxminan qancha?",
            options: [
              "9.8 m/s²",
              "6.67 m/s²",
              "3.14 m/s²",
              "1 m/s²",
            ],
            correctOptionIndex: 0,
          ),
        ],
      ),
      PhysicsTopic(
        title: "Ish va energiya",
        description: "Ish kuchning yo‘lga ko‘paytmasiga teng, energiya esa ish qilish qobiliyati.",
        formula: "W = F * s * cos(θ), E = mgh, K = (1/2)mv²",
        questions: [
          "Ishning o‘lchov birligi nima?",
          "Potensial energiya qanday hisoblanadi?",
          "Kinetik energiya formulasi nima?",
          "Energiyaning saqlanish qonuni nima?",
          "Ish va quvvat o‘rtasidagi farq nima?",
          "Energiyaning o‘zgarishi qanday sodir bo‘ladi?",
          "Mexanik energiya nima?",
        ],
        category: "Energiya",
        tests: [
          TestQuestion(
            question: "Ishning o‘lchov birligi nima?",
            options: [
              "N'yuton",
              "Joul",
              "Vatt",
              "Amper",
            ],
            correctOptionIndex: 1,
          ),
          TestQuestion(
            question: "Kinetik energiya formulasi qaysi?",
            options: [
              "E = mgh",
              "K = (1/2)mv²",
              "W = F * s",
              "P = W / t",
            ],
            correctOptionIndex: 1,
          ),
          TestQuestion(
            question: "Energiyaning saqlanish qonuni nima haqida?",
            options: [
              "Energiya yo‘qoladi",
              "Energiya o‘zgaradi, lekin umumiy miqdori saqlanadi",
              "Energiya faqat kinetik bo‘ladi",
              "Energiya faqat potensial bo‘ladi",
            ],
            correctOptionIndex: 1,
          ),
          TestQuestion(
            question: "Agar massa 1 kg, tezlik 2 m/s bo‘lsa, kinetik energiya qancha?",
            options: [
              "2 J",
              "4 J",
              "1 J",
              "8 J",
            ],
            correctOptionIndex: 0,
          ),
        ],
      ),
      PhysicsTopic(
        title: "Issiqlik va temperatura",
        description: "Issiqlik molekulalarning harakat energiyasi bilan bog‘liq, temperatura esa uning o‘lchovidir.",
        formula: "Q = m * c * ΔT",
        questions: [
          "Issiqlik nima?",
          "Temperatura qanday o‘lchanadi?",
          "Maxsus issiqlik sig‘imi nima?",
          "Issiqlik o‘tkazish usullari qaysilar?",
          "Termodinamikaning birinchi qonuni nima?",
          "Issiqlik miqdori qanday hisoblanadi?",
          "Fazaviy o‘zgarishlar qanday sodir bo‘ladi?",
        ],
        category: "Termodinamika",
        tests: [
          TestQuestion(
            question: "Issiqlik miqdorining formulasi qaysi?",
            options: [
              "Q = m * c * ΔT",
              "Q = F * s",
              "Q = m * g * h",
              "Q = k * q / r",
            ],
            correctOptionIndex: 0,
          ),
          TestQuestion(
            question: "Maxsus issiqlik sig‘imi nima uchun kerak?",
            options: [
              "Massani o‘lchash",
              "Temperatura o‘zgarishini hisoblash",
              "Tezlikni aniqlash",
              "Kuchni hisoblash",
            ],
            correctOptionIndex: 1,
          ),
          TestQuestion(
            question: "Issiqlik o‘tkazish usullaridan biri qaysi?",
            options: [
              "Konveksiya",
              "Inersiya",
              "Gravitatsiya",
              "Reaksiya",
            ],
            correctOptionIndex: 0,
          ),
          TestQuestion(
            question: "Suvning maxsus issiqlik sig‘imi taxminan qancha?",
            options: [
              "4200 J/(kg·K)",
              "1000 J/(kg·K)",
              "200 J/(kg·K)",
              "900 J/(kg·K)",
            ],
            correctOptionIndex: 0,
          ),
        ],
      ),
      PhysicsTopic(
        title: "Elektrostatika",
        description: "Zaryadlangan jismlar o‘zaro elektromagnetik kuchlar bilan ta’sirlanadi.",
        formula: "F = k * (q₁ * q₂) / r²",
        questions: [
          "Elektr zaryadi nima?",
          "Kulon qonuni qanday ishlaydi?",
          "Elektr maydon nima?",
          "Zaryadlar qanday taqsimlanadi?",
          "Elektr potensiali nima?",
          "O‘tkazgichlarda zaryad qanday harakat qiladi?",
          "Dielektriklarda nimalar sodir bo‘ladi?",
        ],
        category: "Elektromagnitizm",
        tests: [
          TestQuestion(
            question: "Kulon qonuni formulasi qaysi?",
            options: [
              "F = m * a",
              "F = k * (q₁ * q₂) / r²",
              "F = G * (m₁ * m₂) / r²",
              "F = m * g",
            ],
            correctOptionIndex: 1,
          ),
          TestQuestion(
            question: "Elektr maydon qanday kattalik?",
            options: [
              "Skalyar",
              "Vektorial",
              "Konstanta",
              "Nisbat",
            ],
            correctOptionIndex: 1,
          ),
          TestQuestion(
            question: "Elektr zaryadning o‘lchov birligi nima?",
            options: [
              "Amper",
              "Kulon",
              "Vatt",
              "Joul",
            ],
            correctOptionIndex: 1,
          ),
          TestQuestion(
            question: "Agar masofa 2 barobar oshsa, elektr kuchi qanday o‘zgaradi?",
            options: [
              "2 barobar oshadi",
              "2 barobar kamayadi",
              "4 barobar kamayadi",
              "4 barobar oshadi",
            ],
            correctOptionIndex: 2,
          ),
        ],
      ),
      PhysicsTopic(
        title: "Doimiy elektr toki",
        description: "Elektr zaryadlarining tartiblangan harakati elektr tok deb ataladi.",
        formula: "I = U / R",
        questions: [
          "Elektr toki nima?",
          "Om qonuni qanday ishlaydi?",
          "Qarshilik qanday o‘lchanadi?",
          "Elektr quvvati nima?",
          "Tok kuchi qanday hisoblanadi?",
          "Rezistorlar qanday ulanadi?",
          "Elektr tarmog‘ida nimalar sodir bo‘ladi?",
        ],
        category: "Elektromagnitizm",
        tests: [
          TestQuestion(
            question: "Om qonuni formulasi qaysi?",
            options: [
              "I = U / R",
              "F = m * a",
              "Q = m * c * ΔT",
              "P = W / t",
            ],
            correctOptionIndex: 0,
          ),
          TestQuestion(
            question: "Elektr quvvati qanday hisoblanadi?",
            options: [
              "P = U * I",
              "P = F * s",
              "P = m * g * h",
              "P = k * q / r",
            ],
            correctOptionIndex: 0,
          ),
          TestQuestion(
            question: "Qarshilikning o‘lchov birligi nima?",
            options: [
              "Amper",
              "Om",
              "Vatt",
              "Kulon",
            ],
            correctOptionIndex: 1,
          ),
          TestQuestion(
            question: "Agar kuchlanish 12 V, qarshilik 4 Om bo‘lsa, tok kuchi qancha?",
            options: [
              "2 A",
              "3 A",
              "4 A",
              "6 A",
            ],
            correctOptionIndex: 1,
          ),
        ],
      ),
      PhysicsTopic(
        title: "Optika: Yorug‘lik sinishi",
        description: "Yorug‘lik muhitdan muhitga o‘tayotganda yo‘nalishi o‘zgaradi.",
        formula: "n₁ * sin(θ₁) = n₂ * sin(θ₂)",
        questions: [
          "Yorug‘lik sinishi nima?",
          "Sinish ko‘rsatkichi nima?",
          "Snell qonuni qanday ishlaydi?",
          "To‘liq ichki qaytish nima?",
          "Linza qanday ishlaydi?",
          "Yorug‘likning sinishi qayerda qo‘llaniladi?",
          "Optik muhit nima?",
        ],
        category: "Optika",
        tests: [
          TestQuestion(
            question: "Snell qonuni formulasi qaysi?",
            options: [
              "n₁ * sin(θ₁) = n₂ * sin(θ₂)",
              "F = m * a",
              "Q = m * c * ΔT",
              "I = U / R",
            ],
            correctOptionIndex: 0,
          ),
          TestQuestion(
            question: "Sinish ko‘rsatkichi nima bilan o‘lchanadi?",
            options: [
              "Metrlarda",
              "Nisbiy kattalik",
              "Joul",
              "Amper",
            ],
            correctOptionIndex: 1,
          ),
          TestQuestion(
            question: "To‘liq ichki qaytish qachon sodir bo‘ladi?",
            options: [
              "Nur parallel bo‘lganda",
              "Kritik burchakdan katta bo‘lganda",
              "Sinish burchagi 0 bo‘lganda",
              "Nur perpendikulyar bo‘lganda",
            ],
            correctOptionIndex: 1,
          ),
          TestQuestion(
            question: "Suvning sinish ko‘rsatkichi taxminan qancha?",
            options: [
              "1.0",
              "1.33",
              "1.5",
              "2.0",
            ],
            correctOptionIndex: 1,
          ),
        ],
      ),
      PhysicsTopic(
        title: "To‘lqinlar va ovoz",
        description: "To‘lqinlar energiyani uzatadi, ovoz esa mexanik to‘lqin sifatida tarqaladi.",
        formula: "V = λ * f",
        questions: [
          "To‘lqin nima?",
          "Ovoz qanday tarqaladi?",
          "Chastota nima?",
          "To‘lqin uzunligi qanday o‘lchanadi?",
          "Ovozning tezligi qanday muhitga bog‘liq?",
          "Doppler effekti nima?",
          "To‘lqinlar qanday tasniflanadi?",
        ],
        category: "To‘lqinlar",
        tests: [
          TestQuestion(
            question: "To‘lqin tezligi formulasi qaysi?",
            options: [
              "V = λ * f",
              "F = m * a",
              "Q = m * c * ΔT",
              "I = U / R",
            ],
            correctOptionIndex: 0,
          ),
          TestQuestion(
            question: "Ovozning havodagi tezligi taxminan qancha?",
            options: [
              "343 m/s",
              "300 m/s",
              "400 m/s",
              "500 m/s",
            ],
            correctOptionIndex: 0,
          ),
          TestQuestion(
            question: "Doppler effekti nima bilan bog‘liq?",
            options: [
              "Chastota o‘zgarishi",
              "Tezlanish",
              "Kuch",
              "Massa",
            ],
            correctOptionIndex: 0,
          ),
          TestQuestion(
            question: "To‘lqin uzunligi qanday o‘lchanadi?",
            options: [
              "Hert",
              "Met",
              "Sekund",
              "Joul",
            ],
            correctOptionIndex: 1,
          ),
        ],
      ),
    ]);
  }
}