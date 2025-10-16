import '../models/question_model.dart';

class LocalSurveyDatasource {
  final List<Map<String, dynamic>> _json = [
    {
      "id": 1,
      "question": "What is your name?",
      "type": "text",
      "required": true,
    },
    {
      "id": 2,
      "question": "What is your gender?",
      "type": "radio",
      "options": ["Male", "Female", "Other"],
      "required": true,
    },
    {
      "id": 3,
      "question": "Which technology do you prefer?",
      "type": "dropdown",
      "options": ["Flutter", "React Native", "Swift", "Kotlin"],
      "required": false,
    },
    {
      "id": 4,
      "question": "How many years of experience do you have?",
      "type": "dropdown",
      "options": ["<1 year", "1-2 years", "3-5 years", "5+ years"],
      "required": true,
    },
    {
      "id": 5,
      "question": "Tell us about yourself (short bio).",
      "type": "textarea",
      "required": false,
    },
    {
      "id": 6,
      "question": "What is your date of birth?",
      "type": "date",
      "required": true,
    },
    {
      "id": 7,
      "question": "Do you want to receive our newsletter?",
      "type": "checkbox",
      "options": ["Yes"],
      "required": false,
    },
    {
      "id": 8,
      "question": "Rate your proficiency in Flutter.",
      "type": "slider",
      "min": 1,
      "max": 10,
      "required": true,
    },
  ];

  Future<List<QuestionModel>> getSurvey() async {
    // await Future.delayed(Duration(milliseconds: 200));
    return _json.map((e) => QuestionModel.fromJson(e)).toList();
  }
}
