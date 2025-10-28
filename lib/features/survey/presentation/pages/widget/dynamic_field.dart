import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:survey_app/features/survey/domain/entity/questions.dart';
import 'package:survey_app/features/survey/presentation/controller/controller.dart';

class DynamicField extends StatelessWidget {
  final Question question;

  const DynamicField({super.key, required this.question});

  SurveyController get ctrl => Get.find<SurveyController>();

  @override
  Widget build(BuildContext context) {
    final qid = question.id;
    switch (question.type) {
      case 'text':
        return CustomTextField(
          labelText: question.question,
          ctrl: ctrl,
          qid: qid,
          icon: Icons.text_fields,
        );
      case 'textarea':
        return CustomTextField(
          labelText: question.question,
          initialValue: ctrl.answers[qid] as String?,
          ctrl: ctrl,
          qid: qid,
          maxLines: 4,
          onChanged: (v) => ctrl.updateAnswer(qid, v),
          icon: Icons.notes,
        );

      case 'radio':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.radio_button_checked,
                    size: 20,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    question.question,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            ...?question.options?.map(
              (opt) => Obx(() {
                final selected = ctrl.answers[qid] as String?;
                return Container(
                  margin: EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: selected == opt
                          ? Colors.blue
                          : Colors.grey.shade300,
                      width: selected == opt ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: selected == opt
                        ? Colors.blue.withValues(alpha: 0.05)
                        : Colors.transparent,
                  ),
                  child: RadioListTile<String>(
                    title: Text(
                      opt,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: selected == opt
                            ? FontWeight.w600
                            : FontWeight.normal,
                        color: selected == opt
                            ? Colors.blue[800]
                            : Colors.grey[700],
                      ),
                    ),
                    value: opt,
                    groupValue: selected,
                    activeColor: Colors.blue,
                    onChanged: (v) => ctrl.updateAnswer(qid, v),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  ),
                );
              }),
            ),
          ],
        );

      case 'checkbox':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.checklist, size: 20, color: Colors.green),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    question.question,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            ...?question.options?.map(
              (opt) => Obx(() {
                final list = (ctrl.answers[qid] ?? <String>[]) as List<String>;
                final checked = list.contains(opt);
                return Container(
                  margin: EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: checked ? Colors.blue : Colors.grey.shade300,
                      width: checked ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: checked
                        ? Colors.blue.withValues(alpha: 0.05)
                        : Colors.transparent,
                  ),
                  child: CheckboxListTile(
                    title: Text(
                      opt,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: checked
                            ? FontWeight.w600
                            : FontWeight.normal,
                        color: checked ? Colors.blue[800] : Colors.grey[700],
                      ),
                    ),
                    value: checked,
                    activeColor: Colors.blue,
                    onChanged: (v) {
                      final newList = List<String>.from(list);
                      if (v == true) {
                        newList.add(opt);
                      } else {
                        newList.remove(opt);
                      }
                      ctrl.updateAnswer(qid, newList);
                    },
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  ),
                );
              }),
            ),
          ],
        );

      case 'dropdown':
        return Obx(() {
          final selected = ctrl.answers[qid] as String?;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.purple.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.arrow_drop_down_circle,
                      size: 20,
                      color: Colors.purple,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      question.question,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              DropdownButton2<String>(
                underline: Container(),
                value: selected != null && question.options!.contains(selected)
                    ? selected
                    : null,
                isExpanded: true,
                isDense: true,
                buttonStyleData: ButtonStyleData(
                  height: 60,
                  padding: EdgeInsets.symmetric(vertical: 0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                dropdownStyleData: DropdownStyleData(
                  offset: Offset(0, -10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                items: question.options
                    ?.map((o) => DropdownMenuItem(value: o, child: Text(o)))
                    .toList(),
                onChanged: (v) => ctrl.updateAnswer(qid, v),
              ),
            ],
          );
        });

      case 'date':
        return Obx(() {
          final DateTime? picked = ctrl.answers[qid] as DateTime?;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.orange.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.calendar_today,
                      size: 20,
                      color: Colors.orange,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      question.question,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final now = DateTime.now();
                  final d = await showDatePicker(
                    context: context,
                    initialDate: picked ?? DateTime(now.year - 20),
                    firstDate: DateTime(1900),
                    lastDate: now,
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary: Colors.blue,
                            onPrimary: Colors.white,
                            onSurface: Colors.grey[800]!,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (d != null) ctrl.updateAnswer(qid, d);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        picked != null
                            ? DateFormat.yMMMd().format(picked)
                            : 'Select date',
                        style: TextStyle(
                          fontSize: 15,
                          color: picked != null
                              ? Colors.grey[800]
                              : Colors.grey[400],
                          fontWeight: picked != null
                              ? FontWeight.w500
                              : FontWeight.normal,
                        ),
                      ),
                      Icon(
                        Icons.calendar_today,
                        size: 20,
                        color: Colors.grey[600],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });

      case 'slider':
        return Obx(() {
          final val = (ctrl.answers[qid] ?? (question.min ?? 1)).toDouble();
          final min = (question.min ?? 1).toDouble();
          final max = (question.max ?? 5).toDouble();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      question.question,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${val.toInt()}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.blue,
                  inactiveTrackColor: Colors.grey[300],
                  trackHeight: 6,
                  thumbColor: Colors.blue,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12),
                  overlayColor: Colors.blue.withValues(alpha: 0.2),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 24),
                  valueIndicatorColor: Colors.blue,
                  valueIndicatorTextStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Slider(
                  min: min,
                  max: max,
                  divisions: (max - min).toInt(),
                  value: val,
                  onChanged: (v) => ctrl.updateAnswer(qid, v),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${min.toInt()}',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    Text(
                      '${max.toInt()}',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ],
          );
        });

      default:
        return SizedBox.shrink();
    }
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.labelText,
    required this.ctrl,
    required this.qid,
    this.onChanged,
    this.maxLines,
    this.initialValue,
    required this.icon,
  });

  final SurveyController ctrl;
  final int qid;
  final String labelText;
  final void Function(String)? onChanged;
  final int? maxLines;
  final String? initialValue;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 10,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 20, color: Colors.blue),
            ),
            Text(
              labelText,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        TextFormField(
          initialValue: initialValue,
          maxLines: maxLines,
          style: TextStyle(fontSize: 15, color: Colors.grey[800]),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[50],
            hintText: "Type your answer here...",
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 15),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onChanged: (v) => ctrl.updateAnswer(qid, v),
        ),
      ],
    );
  }
}
