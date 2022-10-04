import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

const String url = 'http://10.0.2.2:8000/api/documents';

Future getDocuments() async {
  var response = await http.get(Uri.parse(url));
  return json.decode(response.body);
}

Future saveDocument(documentName, organizationName, date, typeId, categoryId,
    statusId, file, signature, user_id) async {
  var request = http.MultipartRequest("POST", Uri.parse(url));

  request.fields['document_name'] = documentName;
  request.fields['organization_name'] = documentName;
  request.fields['date'] = date;
  request.fields['type_id'] = typeId;
  request.fields['category_id'] = categoryId;
  request.fields['status_id'] = statusId;

  request.files.add(
    http.MultipartFile.fromBytes('file_upload', File(file).readAsBytesSync(),
        filename: file),
  );
  if (typeId == '2') {
    request.files.add(
      http.MultipartFile.fromBytes(
          'signature', File(signature).readAsBytesSync(),
          filename: signature),
    );
    // request.fields['signature'] = signature;
  }
  request.fields['user_id'] = user_id;

  print(signature);

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
  // print(response.body);
  return json.decode(response.body);
}
