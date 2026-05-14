// Savol va javob modellar
class QuestionModel {
  final String id;
  final String text;
  final List<OptionModel> options;

  QuestionModel({required this.id, required this.text, required this.options});

  factory QuestionModel.fromApiJson(Map<String, dynamic> json) {
    final answers = json['answers'] as List? ?? [];
    return QuestionModel(
      id: json['_id'] ?? '',
      text: json['question'] ?? '',
      options: answers.asMap().entries.map((entry) {
        return OptionModel.fromApiJson(entry.value, entry.key);
      }).toList(),
    );
  }
}

class OptionModel {
  final String text;
  final String value;
  final bool isCorrect;

  OptionModel({required this.text, required this.value, required this.isCorrect});

  factory OptionModel.fromApiJson(Map<String, dynamic> json, int index) {
    return OptionModel(
      text: json['answer'] ?? '',
      value: String.fromCharCode(65 + index),
      isCorrect: json['correct'] ?? false,
    );
  }
}