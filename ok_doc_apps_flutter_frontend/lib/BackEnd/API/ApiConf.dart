import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:kp_project/FrontEnd/Models/document.dart';

const String url = 'http://10.0.2.2:8000/api/documents';

class ServicesGetApi {
  static List<Document> parseDocuments(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Document>((json) => Document.fromJson(json)).toList();
  }

  static Future<List<Document>> getDocuments() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<Document> list = parseDocuments(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

Future saveDocument(documentName, organizationName, date, typeId, categoryId,
    statusId, filepath, filename, signature, user_id) async {
  var request = http.MultipartRequest("POST", Uri.parse(url));

  request.fields['document_name'] = documentName;
  request.fields['organization_name'] = documentName;
  request.fields['date'] = date;
  request.fields['type_id'] = typeId;
  request.fields['category_id'] = categoryId;
  request.fields['status_id'] = statusId;

  request.files.add(
    http.MultipartFile.fromBytes(
        'file_upload', File(filepath).readAsBytesSync(),
        filename: filename),
  );
  if (typeId == '2') {
    request.files.add(
      http.MultipartFile.fromBytes(
          'signature', File(signature).readAsBytesSync(),
          filename: signature),
    );
  } else {
    request.fields['signature'] = "unSigned";
  }

  request.fields['user_id'] = user_id;

  await request.send().then(
    (response) {
      if (response.statusCode == 200) {
        print("Uploaded!");
      } else {
        print(response);
      }
    },
  );
}

Future deleteDocument(String documentId) async {
  var response = await http.delete(Uri.parse('$url/$documentId'));
  return json.decode(response.body);
}

Future updateDocument(documentId, documentName, organizationName, date, typeId,
    categoryId, statusId, userId) async {
  final response = await http.put(
    Uri.parse('$url/$documentId'),
    body: {
      "document_name": documentName,
      "organization_name": organizationName,
      "date": date,
      "type_id": typeId,
      "category_id": categoryId,
      "status_id": statusId,
      "user_id": userId,
    },
  );
  return json.decode(response.body);
}
