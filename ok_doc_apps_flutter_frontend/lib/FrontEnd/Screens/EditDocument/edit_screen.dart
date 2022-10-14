// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kp_project/BackEnd/API/ApiConf.dart';
import 'package:kp_project/FrontEnd/Models/document.dart';
import 'package:kp_project/FrontEnd/Screens/Home/home_screen.dart';
import 'package:kp_project/utilities/colors.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditScreen extends StatefulWidget {
  final Document document;

  EditScreen({required this.document});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  String? user_id;
  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      user_id = pref.getString("login_id");
    });
  }

  TextEditingController _documentnameController = TextEditingController();
  TextEditingController _organizationnameController = TextEditingController();
  TextEditingController dateinputController = TextEditingController();

  late String _dt = widget.document.type_id.toString(),
      _ds = widget.document.status_id.toString();

  late String? _selectedcategory = widget.document.category_id.toString();
  List categoryItemList = [];

  Future getAllCategories() async {
    var url = "http://192.168.1.8:8000/api/categories";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        categoryItemList = jsonData;
      });
    }
  }

  @override
  Void? initState() {
    dateinputController.text = widget.document.date;
    super.initState();
    getCred();
    getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kSubTextIconClr),
        centerTitle: true,
        title: const Text(
          "Edit Document",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: kMainTextClr,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
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
                            color: Color(0xffEAEAEA)),
                        alignment: Alignment.center,
                        child: TextField(
                          controller: _documentnameController
                            ..text = widget.document.document_name,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: kMainTextClr),
                          cursorColor: kMainTextClr,
                          decoration: const InputDecoration(
                              hintText: "Insert Your Document Name",
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
                            color: Color(0xffEAEAEA)),
                        alignment: Alignment.center,
                        child: TextField(
                          controller: _organizationnameController
                            ..text = widget.document.organization_name,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: kMainTextClr),
                          cursorColor: kMainTextClr,
                          decoration: const InputDecoration(
                              hintText: "INSERT ORGANIZATION NAME",
                              hintStyle: TextStyle(
                                  fontSize: 11,
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
                            color: Color(0xffEAEAEA)),
                        alignment: Alignment.center,
                        child: TextField(
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: kMainTextClr),
                          controller: dateinputController,
                          decoration: const InputDecoration(
                              icon: Icon(Icons.calendar_month),
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
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              setState(() {
                                dateinputController.text = formattedDate;
                              });
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
                                  ;
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
                                  color: kBoxFormClr),
                              alignment: Alignment.center,
                              child: DropdownButtonFormField(
                                decoration: const InputDecoration(
                                    hintText: "CHOOSE DOCUMENT'S CATEGORY",
                                    hintStyle: TextStyle(
                                        fontSize: 11,
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
                            title: Text("Validated"),
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
                            title: Text("UnValidated"),
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
                            title: const Text("Depreceated"),
                            value: "3",
                            groupValue: _ds,
                            onChanged: (value) {
                              setState(() {
                                _ds = value.toString();
                              });
                            },
                            activeColor: kMainTextClr,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MaterialButton(
                        color: kButtonClr,
                        onPressed: () {
                          updateDocument(
                                  widget.document.id,
                                  _documentnameController.text,
                                  _organizationnameController.text,
                                  dateinputController.text,
                                  _dt,
                                  _selectedcategory,
                                  _ds,
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
                                  content: Text("Document Updated"),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            },
                          );
                        },
                        child: const Text(
                          "Update",
                          style: TextStyle(color: kButtonTextClr),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
