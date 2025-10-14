import 'package:survey_app/features/survey/data/datasource/local_datasource.dart';
import 'package:survey_app/features/survey/domain/entity/questions.dart';

class SurveyRepositoryImpl {
  final LocalSurveyDatasource datasource;
  SurveyRepositoryImpl(this.datasource);

  Future<List<Question>> getSurvey() async {
    return datasource.getSurvey();
  }
}
