import 'package:get/get.dart';
import 'package:survey_app/features/survey/data/datasource/local_datasource.dart';
import 'package:survey_app/features/survey/data/repository/repo_impl.dart';
import 'package:survey_app/features/survey/presentation/controller/controller.dart';

class SurveyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalSurveyDatasource>(() => LocalSurveyDatasource());
    Get.lazyPut<SurveyRepositoryImpl>(
      () => SurveyRepositoryImpl(Get.find<LocalSurveyDatasource>()),
    );
    Get.lazyPut<SurveyController>(
      () => SurveyController(repo: Get.find<SurveyRepositoryImpl>()),
    );
  }
}
