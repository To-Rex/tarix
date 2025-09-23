import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/physics_controller.dart';
import '../models/physics_topic.dart';

class DetailScreen extends StatelessWidget {
  final PhysicsTopic topic;
  const DetailScreen({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PhysicsController>();
    final selectedAnswers = List<int?>.filled(topic.tests.length, null).obs;
    final answerResults = List<bool?>.filled(topic.tests.length, null).obs;

    // Savollar uchun umumiy javoblar (misol sifatida)
    final Map<String, String> questionAnswers = {
      "Inertsiya nima?": "Inertsiya – jismning harakatga yoki harakatsizlikka qarshilik ko‘rsatish xususiyati.",
      "Qanday hollarda jism harakatsiz qoladi?": "Jismga tashqi kuch ta’sir qilmasa yoki kuchlar muvozanatda bo‘lsa, jism harakatsiz qoladi.",
      "Birinchi qonun qayerda qo‘llaniladi?": "Transport vositalarining harakati, kosmik kemalar va kundalik jismlar misolida qo‘llaniladi.",
      "Kuchning yo‘qligi nimani anglatadi?": "Kuch yo‘q bo‘lsa, jismning tezligi o‘zgarmaydi, ya’ni inertsiya saqlanadi.",
      "Inertsiya massaga qanday bog‘liq?": "Inertsiya jismning massasiga to‘g‘ri proportsional, massa qanchalik katta bo‘lsa, inertsiya ham shuncha katta.",
      "Birinchi qonun misollari nimalardan iborat?": "Misollar: kitob stol ustida harakatsiz turgani, mashina tekis yo‘lda doimiy tezlikda harakatlanishi.",
      "Jismning harakat holati qanday o‘zgaradi?": "Jismning harakat holati faqat tashqi kuch ta’sirida o‘zgaradi.",
      "Kuchning o‘lchov birligi nima?": "Kuch N’yuton (N) bilan o‘lchanadi, 1 N = 1 kg·m/s².",
      "Tezlanish qanday aniqlanadi?": "Tezlanish – tezlikning vaqtga nisbatan o‘zgarishi, a = Δv/Δt.",
      "Massa o‘zgarmasa, kuch qanday o‘zgaradi?": "Massa doimiy bo‘lsa, kuch tezlanishga to‘g‘ri proportsional: F = m·a.",
      // Boshqa savollar uchun javoblar shu tarzda qo‘shilishi mumkin
    };

    return Scaffold(
      backgroundColor: Colors.transparent, // main.dart bilan mos
      appBar: AppBar(
        title: Text(topic.title.tr),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).appBarTheme.iconTheme?.color),
          onPressed: () => Get.back(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: controller.isDarkMode.value
                ? [const Color(0xFF121212), const Color(0xFF1E1E1E)]
                : [const Color(0xFFF5F7FA), const Color(0xFFE3F2FD)],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Mavzu haqida ma'lumot
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                color: Theme.of(context).cardTheme.color,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: controller.isDarkMode.value
                                ? [const Color(0xFF42A5F5).withOpacity(0.3), const Color(0xFF42A5F5).withOpacity(0.1)]
                                : [const Color(0xFF1976D2).withOpacity(0.3), const Color(0xFF1976D2).withOpacity(0.1)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.science,
                          size: 24,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Tavsif',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        topic.description.tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      if (topic.formula.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Text(
                          'Formula',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          topic.formula,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Testlar
              Text(
                'Testlar (${topic.tests.length})',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              ...List.generate(topic.tests.length, (index) {
                final test = topic.tests[index];
                return Obx(
                      () => Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    color: Theme.of(context).cardTheme.color,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Savol ${index + 1}: ${test.question}',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ...List.generate(test.options.length, (optionIndex) {
                            return RadioListTile<int>(
                              value: optionIndex,
                              groupValue: selectedAnswers[index],
                              onChanged: selectedAnswers[index] == null
                                  ? (value) {
                                selectedAnswers[index] = value;
                                answerResults[index] = value == test.correctOptionIndex;
                              }
                                  : null,
                              title: Text(
                                test.options[optionIndex],
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontSize: 14,
                                  color: selectedAnswers[index] != null
                                      ? (optionIndex == test.correctOptionIndex
                                      ? Colors.green[controller.isDarkMode.value ? 300 : 700]
                                      : optionIndex == selectedAnswers[index]
                                      ? Colors.red[controller.isDarkMode.value ? 300 : 700]
                                      : null)
                                      : null,
                                ),
                              ),
                              activeColor: Theme.of(context).iconTheme.color,
                            );
                          }),
                          if (selectedAnswers[index] != null) ...[
                            const SizedBox(height: 8),
                            AnimatedOpacity(
                              opacity: selectedAnswers[index] != null ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 300),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    answerResults[index] == true ? 'To‘g‘ri!' : 'Noto‘g‘ri!',
                                    style: TextStyle(
                                      color: answerResults[index] == true
                                          ? Colors.green[controller.isDarkMode.value ? 300 : 700]
                                          : Colors.red[controller.isDarkMode.value ? 300 : 700],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'To‘g‘ri javob: ${test.options[test.correctOptionIndex]}',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Theme.of(context).textTheme.bodyMedium?.color,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 16),
              // Savollar va Javoblar
              Text(
                'Savollar va Javoblar (${topic.questions.length})',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              ...topic.questions.map((question) {
                return Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  color: Theme.of(context).cardTheme.color,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          question,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          questionAnswers[question] ?? 'Javob hozircha mavjud emas.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}