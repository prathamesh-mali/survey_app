import 'package:get/get.dart';
import 'package:survey_app/features/survey/presentation/controller/survery_bindings.dart';
import '../../features/survey/presentation/pages/survey_page.dart';
import '../../features/survey/presentation/pages/results_page.dart';

class Routes {
  static const survey = '/';
  static const results = '/results';
}

class AppRoutes {
  static final pages = [
    GetPage(
      name: Routes.survey,
      page: () => SurveyPage(),
      binding: SurveyBinding(),
    ),
    GetPage(name: Routes.results, page: () => ResultsPage()),
  ];
}
