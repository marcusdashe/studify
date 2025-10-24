import 'package:studify_flutter_challenge/data/models/quiz_option_model.dart';

class QuizQuestion {
  final String question;
  final List<QuizOption> options;
  final String correctAnswer; // The label of the correct option (A, B, C, D)

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswer,
  });
}