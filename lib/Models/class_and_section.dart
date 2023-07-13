class Sections {
  final List<dynamic> sections;

  Sections({required this.sections});
  Sections.fromJson(Map<String, Object?> json)
      : this(sections: json['sections'] as List);
}
