import 'package:get/get.dart';
import 'package:survey_app/features/survey/data/datasource/local_datasource.dart';
import 'package:survey_app/features/survey/data/repository/repo_impl.dart';
import 'package:survey_app/features/survey/domain/usecase/usecase.dart';
import 'package:survey_app/features/survey/presentation/controller/controller.dart';

class DependencyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalSurveyDatasource>(() => LocalSurveyDatasource());

    Get.lazyPut<SurveyRepositoryImpl>(
      () => SurveyRepositoryImpl(Get.find<LocalSurveyDatasource>()),
    );

    Get.lazyPut<GetSurveyUseCase>(
      () => GetSurveyUseCase(Get.find<SurveyRepositoryImpl>()),
    );

    Get.lazyPut<SurveyController>(
      () => SurveyController(getSurveyUseCase: Get.find<GetSurveyUseCase>()),
    );
  }
}
