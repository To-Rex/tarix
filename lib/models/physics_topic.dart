class TestQuestion {
  final String question;
  final List<String> options;
  final int correctOptionIndex;

  TestQuestion({
    required this.question,
    required this.options,
    required this.correctOptionIndex,
  });
}

class PhysicsTopic {
  final String title;
  final String description;
  final String formula;
  final List<String> questions;
  final String category;
  final List<TestQuestion> tests; // Yangi testlar ro‘yxati

  PhysicsTopic({
    required this.title,
    required this.description,
    required this.formula,
    required this.questions,
    required this.category,
    required this.tests,
  });
}