import 'package:get/get.dart';
import 'package:survey_app/features/survey/data/datasource/local_datasource.dart';
import 'package:survey_app/features/survey/data/repository/repo_impl.dart';
import 'package:survey_app/features/survey/domain/entity/questions.dart';
import 'package:survey_app/features/survey/domain/usecase/usecase.dart';

class SurveyController extends GetxController {
  final _questions = <Question>[].obs;
  List<Question> get questions => _questions;

  final answers = <int, dynamic>{}.obs;

  final isLoading = false.obs;

  final LocalSurveyDatasource _datasource = LocalSurveyDatasource();
  late final SurveyRepositoryImpl _repo;

  SurveyController({GetSurveyUseCase? getSurveyUseCase}) {
    _repo = SurveyRepositoryImpl(_datasource);
  }

  @override
  void onInit() {
    super.onInit();
    loadSurvey();
  }

  Future<void> loadSurvey() async {
    isLoading.value = true;
    final list = await _repo.getSurvey();
    _questions.assignAll(list);

    for (var q in list) {
      if (q.type == 'slider') {
        answers[q.id] = (q.min ?? 1).toDouble();
      } else if (q.type == 'checkbox') {
        answers[q.id] = <String>[];
      } else {
        answers[q.id] = null;
      }
    }
    isLoading.value = false;
  }

  void updateAnswer(int id, dynamic value) {
    answers[id] = value;
  }

  String? validate() {
    for (var q in _questions) {
      if (q.required) {
        final a = answers[q.id];
        if (q.type == 'checkbox') {
          if (a == null || (a is List && a.isEmpty)) {
            return 'Please answer: ${q.question}';
          }
        } else {
          if (a == null || (a is String && a.trim().isEmpty)) {
            return 'Please answer: ${q.question}';
          }
        }
      }
    }
    return null;
  }

  void submit() {
    final err = validate();
    if (err != null) {
      Get.snackbar('Validation', err, snackPosition: SnackPosition.BOTTOM);
      return;
    }

    Get.toNamed('/results', arguments: answers);
  }
}
