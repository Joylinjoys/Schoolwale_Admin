class RuleInfo {
  final String title;
  final String description;

  RuleInfo({
    required this.title,
    required this.description,
  });

  RuleInfo.fromJson(Map<String, Object?> json)
      : this(
    title: json['Title'] as String,
    description: json['Description'] as String,
  );
}
