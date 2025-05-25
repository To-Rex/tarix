// Savol va javob modellar
class QuestionModel {
  final String id;
  final String text;
  final List<OptionModel> options;

  QuestionModel({required this.id, required this.text, required this.options});
}

class OptionModel {
  final String text;
  final String value;
  final bool isCorrect;

  OptionModel({required this.text, required this.value, required this.isCorrect});
}