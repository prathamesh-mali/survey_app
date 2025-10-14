import 'package:survey_app/features/survey/domain/entity/questions.dart';

class QuestionModel extends Question {
  QuestionModel({
    required super.id,
    required super.question,
    required super.type,
    required super.required,
    super.options,
    super.min,
    super.max,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      question: json['question'],
      type: json['type'],
      required: json['required'] ?? false,
      options: json['options'] != null
          ? List<String>.from(json['options'])
          : null,
      min: json['min'] != null ? (json['min'] as num).toDouble() : null,
      max: json['max'] != null ? (json['max'] as num).toDouble() : null,
    );
  }
}
