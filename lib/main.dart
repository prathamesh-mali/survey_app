import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey_app/config/routes.dart';
import 'package:survey_app/config/theme.dart';
import 'package:survey_app/features/survey/data/datasource/local_datasource.dart';
import 'package:survey_app/features/survey/data/repository/repo_impl.dart';
import 'package:survey_app/features/survey/presentation/controller/controller.dart';

void main() {
  final datasource = LocalSurveyDatasource();
  final repo = SurveyRepositoryImpl(datasource);
  Get.put(repo);
  Get.put(SurveyController(getSurveyUseCase: null));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Dynamic Survey',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.survey,
      getPages: AppRoutes.pages,
    );
  }
}
