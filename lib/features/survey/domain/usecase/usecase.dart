import 'package:survey_app/features/survey/data/repository/repo_impl.dart';
import 'package:survey_app/features/survey/domain/entity/questions.dart';

class GetSurveyUseCase {
  final SurveyRepositoryImpl repository;
  GetSurveyUseCase(this.repository);

  Future<List<Question>> call() async {
    return repository.getSurvey();
  }
}
