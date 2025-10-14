class Question {
  final int id;
  final String question;
  final String type; // text, radio, checkbox, dropdown, textarea, date, slider
  final bool required;
  final List<String>? options;
  final double? min;
  final double? max;

  Question({
    required this.id,
    required this.question,
    required this.type,
    required this.required,
    this.options,
    this.min,
    this.max,
  });
}
