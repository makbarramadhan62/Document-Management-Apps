class Document {
  late int id;
  late String document_name;
  late String organization_name;
  late String date;
  late String type_id;
  late String category_id;
  late String category_name;
  late String status_id;
  late String file_upload;
  late String username;

  Document({
    required this.id,
    required this.document_name,
    required this.organization_name,
    required this.date,
    required this.type_id,
    required this.category_id,
    required this.category_name,
    required this.status_id,
    required this.file_upload,
    required this.username,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json['id'] as int,
      document_name: json['document_name'] as String,
      organization_name: json['organization_name'] as String,
      date: json['date'] as String,
      type_id: json['type_id'].toString(),
      category_id: json['category_id'].toString(),
      category_name: json['category_name'] as String,
      status_id: json['status_id'].toString(),
      file_upload: json['file_upload'] as String,
      username: json['username'] as String,
    );
  }
}
