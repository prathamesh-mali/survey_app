import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey_app/features/survey/presentation/controller/controller.dart';
import 'package:survey_app/features/survey/presentation/pages/widget/dynamic_field.dart';

class SurveyPage extends StatelessWidget {
  final SurveyController ctrl = Get.put(SurveyController());

  SurveyPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        title: Text('Survey'),
      ),
      body: Obx(() {
        if (ctrl.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return GestureDetector(
          onTap: () async {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: ctrl.questions.length,
                    separatorBuilder: (_, __) => SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final q = ctrl.questions[index];
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: DynamicField(question: q),
                      );
                    },
                  ),
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  onPressed: () => ctrl.submit(),
                  child: Text('Submit'),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        );
      }),
    );
  }
}
