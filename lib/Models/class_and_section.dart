class Sections {
  final List<dynamic> sections;
  final String classs;
  Sections({required this.sections, required this.classs});
  Sections.fromJson(Map<String, Object?> json)
      : this(
            sections: json['sections'] as List,
            classs: json['class'] as String);
}
