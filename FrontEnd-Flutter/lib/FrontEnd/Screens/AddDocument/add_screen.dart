import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:kp_project/BackEnd/API/ApiConf.dart';
import 'package:kp_project/FrontEnd/Screens/Home/home_screen.dart';
import 'package:kp_project/utilities/colors.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signature/signature.dart';
import 'package:http/http.dart' as http;

class AddScreen extends StatefulWidget {
  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _documentnameController = TextEditingController();
  TextEditingController _organizationnameController = TextEditingController();
  TextEditingController dateinputController = TextEditingController();

  String? _dt, _ds;
  String signature = 'unSigned';

  FilePickerResult? result;
  String? _fileName, _fileExtension, _filePath;
  PlatformFile? pickedfile;
  bool isLoading = false;
  File? fileToDisplay;

  void pickFile() async {
    try {
      setState(() {
        isLoading = true;
      });

      result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );

      final docName = _documentnameController.text;
      final date = DateFormat('d MMM yyyy').format(DateTime.now());

      if (result != null) {
        // _fileName = result!.files.first.name;
        _fileName = 'Document-$docName-$date';
        _fileExtension = result!.files.first.extension;
        _filePath = result!.files.first.path;
        pickedfile = result!.files.first;
        fileToDisplay = File(pickedfile!.path.toString());
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  Uint8List? viewSignature;
  File? signatureFile;
  SignatureController signatureController = SignatureController(
    penStrokeWidth: 3,
    penColor: kMainTextClr,
    exportBackgroundColor: kPrimaryClr,
  );

  String? _selectedcategory;
  List categoryItemList = [];

  Future getAllCategories() async {
    var url = "http://10.0.2.2:8000/api/categories";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        categoryItemList = jsonData;
      });
    }
  }

  String? user_id;
  void GetSeason() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      user_id = pref.getString("login_id");
    });
  }

  @override
  Void? initState() {
    dateinputController.text = "";
    super.initState();
    GetSeason();
    getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kSubTextIconClr),
        centerTitle: true,
        title: const Text(
          "Add Document",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: kMainTextClr,
          ),
        ),
        backgroundColor: kPrimaryClr,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: const <Widget>[
                            Text(
                              "Document Name",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: kMainTextClr),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: kBoxClr),
                          alignment: Alignment.center,
                          child: TextFormField(
                            controller: _documentnameController,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: kMainTextClr),
                            cursorColor: kMainTextClr,
                            decoration: const InputDecoration(
                                hintText: "Insert Document's Name",
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: kSubTextIconClr),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: const <Widget>[
                            Text(
                              "Organization Name",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: kMainTextClr),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: kBoxClr),
                          alignment: Alignment.center,
                          child: TextFormField(
                            controller: _organizationnameController,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: kMainTextClr),
                            cursorColor: kMainTextClr,
                            decoration: const InputDecoration(
                                hintText: "Insert Organization Name",
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: kSubTextIconClr),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: const <Widget>[
                            Text(
                              "Date",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: kMainTextClr),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: kBoxClr),
                          alignment: Alignment.center,
                          child: TextFormField(
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: kMainTextClr),
                            controller: dateinputController,
                            decoration: const InputDecoration(
                                icon: Icon(Icons.calendar_month),
                                hintText: "Choose Date",
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: kSubTextIconClr),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                              );

                              if (pickedDate != null) {
                                print(pickedDate);
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                print(formattedDate);
                                setState(() {
                                  dateinputController.text = formattedDate;
                                });
                              } else {
                                print("Date is no selected");
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: const <Widget>[
                            Text(
                              "Document Type",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: kMainTextClr),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile(
                                dense: true,
                                title: const Text(
                                  "Document In",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: kMainTextClr,
                                  ),
                                ),
                                value: "1",
                                groupValue: _dt,
                                onChanged: (value) {
                                  setState(() {
                                    _dt = value.toString();
                                  });
                                },
                                activeColor: kMainTextClr,
                              ),
                            ),
                            Expanded(
                              child: RadioListTile(
                                dense: true,
                                title: const Text(
                                  "Document Out",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: kMainTextClr,
                                  ),
                                ),
                                value: "2",
                                groupValue: _dt,
                                onChanged: (value) {
                                  setState(() {
                                    _dt = value.toString();
                                    // signature = 'signed';
                                  });
                                },
                                activeColor: kMainTextClr,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: const <Widget>[
                            Text(
                              "Category",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: kMainTextClr),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: kBoxClr),
                                alignment: Alignment.center,
                                child: DropdownButtonFormField(
                                  decoration: const InputDecoration(
                                      hintText: "Choose Category",
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: kSubTextIconClr),
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none),
                                  alignment: Alignment.center,
                                  value: _selectedcategory,
                                  items: categoryItemList
                                      .map(
                                        (categories) => DropdownMenuItem(
                                          value: categories['id'].toString(),
                                          child: Text(
                                            categories['category_name'],
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: kMainTextClr),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (val) {
                                    setState(
                                      () {
                                        _selectedcategory = val as String;
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.arrow_drop_down_circle,
                                    color: kSubTextIconClr,
                                  ),
                                  dropdownColor: kPrimaryClr,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: const <Widget>[
                            Text(
                              "Document Status",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: kMainTextClr),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            RadioListTile(
                              dense: true,
                              title: const Text(
                                "Validated",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: kMainTextClr,
                                ),
                              ),
                              value: "1",
                              groupValue: _ds,
                              onChanged: (value) {
                                setState(() {
                                  _ds = value.toString();
                                });
                              },
                              activeColor: kMainTextClr,
                            ),
                            RadioListTile(
                              dense: true,
                              title: const Text(
                                "UnValidated",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: kMainTextClr,
                                ),
                              ),
                              value: "2",
                              groupValue: _ds,
                              onChanged: (value) {
                                setState(() {
                                  _ds = value.toString();
                                });
                              },
                              activeColor: kMainTextClr,
                            ),
                            RadioListTile(
                              dense: true,
                              title: const Text(
                                "Depreceated",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: kMainTextClr,
                                ),
                              ),
                              value: "3",
                              groupValue: _ds,
                              onChanged: (value) {
                                setState(() {
                                  _ds = value.toString();
                                });
                              },
                              activeColor: kMainTextClr,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: const <Widget>[
                            Text(
                              "Upload File",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: kMainTextClr),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            color: kBoxClr,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (pickedfile != null)
                                    SizedBox(
                                      child: Column(
                                        children: [
                                          // Image.file(fileToDisplay!),
                                          Container(
                                            alignment: Alignment.center,
                                            height: 100,
                                            width: 200,
                                            decoration: BoxDecoration(
                                              color: kButtonClr,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Text(
                                              _fileExtension!,
                                              style: const TextStyle(
                                                  fontSize: 28,
                                                  fontWeight: FontWeight.bold,
                                                  color: kPrimaryClr),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            _fileName!,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: kSubTextIconClr),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ElevatedButton(
                                    onPressed: () {
                                      pickFile();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: kButtonClr,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      textStyle: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    child: const Text(
                                      'Choose File',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (_dt == "2")
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            padding: const EdgeInsets.all(0),
                            child: Column(
                              children: [
                                Row(
                                  children: const <Widget>[
                                    Text(
                                      "Signature",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: kMainTextClr),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    color: kBoxClr,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          if (viewSignature != null &&
                                              pickedSignature == null)
                                            const Text(
                                                "Please Upload Signature Manually :)"),
                                          // Image.memory(
                                          //   viewSignature!,
                                          //   width: 300,
                                          //   height: 300,
                                          // ),
                                          if (pickedSignature != null)
                                            SizedBox(
                                              child: Column(
                                                children: [
                                                  Image.file(
                                                      signatureToDisplay!),
                                                ],
                                              ),
                                            ),
                                          Column(
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  SignaturePopUp(context);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: kButtonClr,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                                  textStyle: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                child: const Text(
                                                  'Add New',
                                                ),
                                              ),
                                              const Text(
                                                "or",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  pickSignature();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: kButtonClr,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                                  textStyle: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                child: const Text(
                                                  'Upload File',
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(
                          height: 10,
                        ),
                        MaterialButton(
                          color: kButtonClr,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              saveDocument(
                                      _documentnameController.text,
                                      _organizationnameController.text,
                                      dateinputController.text,
                                      _dt,
                                      _selectedcategory,
                                      _ds,
                                      _filePath,
                                      _signaturePath,
                                      user_id)
                                  .then(
                                (value) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomeScreen(),
                                      ),
                                      (route) => false);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Document Added"),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                          child: const Text(
                            "Submit",
                            style: TextStyle(color: kButtonTextClr),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  FilePickerResult? signatureResult;
  String? _signatureName, _signatureExtension, _signaturePath;
  PlatformFile? pickedSignature;
  File? signatureToDisplay;

  void pickSignature() async {
    try {
      setState(() {
        isLoading = true;
      });

      signatureResult = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );

      if (signatureResult != null) {
        _signatureName = signatureResult!.files.first.name;
        _signatureExtension = signatureResult!.files.first.extension;
        _signaturePath = signatureResult!.files.first.path;
        pickedSignature = signatureResult!.files.first;
        signatureToDisplay = File(pickedSignature!.path.toString());
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  Uint8List? signatureUpload;
  Future storeSignature() async {
    final status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    final docName = _documentnameController.text;
    final date = DateFormat('d MMM yyyy').format(DateTime.now());
    _signatureName = 'Signature-$docName-$date';

    final result = await ImageGallerySaver.saveImage(viewSignature!,
        name: _signatureName, quality: 100);

    // _signaturePath = File("/storage/emulated/0/Pictures/$_signatureName.jpg")
    //     .readAsString() as String?;

    // final tempPath = await getTemporaryDirectory();
    // signatureFile =
    //     await File('${tempPath.path}/${_signatureName}.png').create();
    // signatureFile!.writeAsBytesSync(signatureUpload!);
    // _signaturePath = signatureFile!.path;

    // print(signatureUpload);
    // print(_signaturePath);
  }

  SignaturePopUp(context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kPrimaryClr,
              ),
              padding: const EdgeInsets.all(10),
              height: 318,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Signature(
                    controller: signatureController,
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    backgroundColor: kPrimaryClr,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          signatureController.clear();
                        },
                        color: kDangerClr,
                        child: const Text(
                          "Clear",
                          style: TextStyle(color: kButtonTextClr),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () async {
                          viewSignature =
                              await signatureController.toPngBytes();
                          setState(() {
                            signatureUpload = viewSignature;
                            storeSignature();
                          });
                        },
                        color: kButtonClr,
                        child: const Text(
                          "Save",
                          style: TextStyle(color: kButtonTextClr),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
