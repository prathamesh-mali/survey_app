import 'package:get/get.dart';
import 'package:survey_app/features/survey/data/repository/repo_impl.dart';
import 'package:survey_app/features/survey/domain/entity/questions.dart';

class SurveyController extends GetxController {
  final RxList<Question> _questions = <Question>[].obs;
  List<Question> get questions => _questions;

  final RxMap<int, dynamic> answers = <int, dynamic>{}.obs;
  final RxBool isLoading = false.obs;

  final SurveyRepositoryImpl _repo;

  SurveyController({required SurveyRepositoryImpl repo}) : _repo = repo;

  @override
  void onInit() {
    super.onInit();

    Future.microtask(loadSurvey);
  }

  Future<void> loadSurvey() async {
    try {
      isLoading.value = true;

      final list = await _repo.getSurvey();
      _questions.assignAll(list);

      _initializeAnswers(list);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load survey: $e',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void _initializeAnswers(List<Question> list) {
    for (final q in list) {
      switch (q.type) {
        case 'slider':
          answers[q.id] = (q.min ?? 1).toDouble();
          break;
        case 'checkbox':
          answers[q.id] = <String>[];
          break;
        case 'dropdown':
          answers[q.id] = null;
          break;

        default:
          answers[q.id] = null;
      }
    }
  }

  void updateAnswer(int id, dynamic value) {
    if (!answers.containsKey(id)) return;
    answers[id] = value;
  }

  String? validate() {
    for (final q in _questions) {
      if (!q.required) continue;

      final a = answers[q.id];
      if (q.type == 'checkbox') {
        if (a == null || (a is List && a.isEmpty)) {
          return 'Please answer: ${q.question}';
        }
      } else if (a == null || (a is String && a.trim().isEmpty)) {
        return 'Please answer: ${q.question}';
      }
    }
    return null;
  }

  void submit() {
    final error = validate();
    if (error != null) {
      Get.snackbar('Validation', error, snackPosition: SnackPosition.BOTTOM);
      return;
    }

    Get.toNamed('/results', arguments: answers);
  }

  void clear() {
    for (final q in _questions) {
      switch (q.type) {
        case 'slider':
          answers[q.id] = (q.min ?? 1).toDouble();
          break;
        case 'checkbox':
          answers[q.id] = <String>[];
          break;
        default:
          answers[q.id] = '';
      }
    }
    Get.snackbar("Clear", "Cleared Successfully");
  }
}
