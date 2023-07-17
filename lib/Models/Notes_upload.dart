import 'dart:io';

class UploadNotes {
  final String className;
  final String section;
  final String subject;
  final String title;
  final File pdfFile;

  UploadNotes({
    required this.className,
    required this.section,
    required this.subject,
    required this.title,
    required this.pdfFile,
  });

  UploadNotes.fromJson(Map<String, dynamic> json)
      : this(
    className: json['className'] as String,
    section: json['section'] as String,
    subject: json['subject'] as String,
    title: json['title'] as String,
    pdfFile: File(json['pdfFilePath'] as String),
  );

  Map<String, dynamic> toJson() {
    return {
      'className': className,
      'section': section,
      'subject': subject,
      'title': title,
      'pdfFilePath': pdfFile.path,
    };
  }
}
