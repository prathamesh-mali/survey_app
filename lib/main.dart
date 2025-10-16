import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey_app/config/bindings.dart';
import 'package:survey_app/config/routes.dart';
import 'package:survey_app/config/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      initialBinding: DependencyBinding(),
    );
  }
}
