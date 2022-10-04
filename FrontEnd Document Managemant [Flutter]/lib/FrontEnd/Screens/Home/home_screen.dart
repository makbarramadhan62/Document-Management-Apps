// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kp_project/BackEnd/API/CRUD.dart';
import 'package:kp_project/FrontEnd/Components/AppBar.dart';
import 'package:kp_project/FrontEnd/Screens/AddDocument/add_screen.dart';
import 'package:kp_project/FrontEnd/Screens/DetailDocument/detail_screen.dart';
import 'package:kp_project/FrontEnd/Screens/EditDocument/edit_screen.dart';
import 'package:kp_project/FrontEnd/Screens/Home/Widget/SideBar.dart';
import 'package:kp_project/FrontEnd/Screens/Login/login_screen.dart';
import 'package:kp_project/utilities/colors.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

enum DialogsAction { yes, cancel }

class AlertDialogs {
  static Future<DialogsAction> yesCancelDialog(
    BuildContext context,
    String title,
    String body,
  ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: kMainTextClr,
            ),
          ),
          content: Text(
            body,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: kMainTextClr,
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(
                  onPressed: () =>
                      Navigator.of(context).pop(DialogsAction.cancel),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                        color: kMainTextClr, fontWeight: FontWeight.bold),
                  ),
                ),
                MaterialButton(
                  onPressed: () => Navigator.of(context).pop(DialogsAction.yes),
                  child: const Text(
                    'Yes',
                    style: TextStyle(
                        color: kDangerClr, fontWeight: FontWeight.w700),
                  ),
                )
              ],
            )
          ],
        );
      },
    );
    return (action != null) ? action : DialogsAction.cancel;
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool tappedYes = false;
  String? token_id = "";
  String? token_username = "";

  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      token_id = pref.getString("login_id");
      token_username = pref.getString("login_username");
    });
  }

  @override
  void initState() {
    super.initState();
    getCred();
  }

  @override
  Widget build(BuildContext context) {
    getDocuments();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kSubTextIconClr),
        centerTitle: true,
        title: const Text(
          "Home",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: kMainTextClr,
          ),
        ),
        backgroundColor: kPrimaryClr,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.notifications_outlined,
              size: 28,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi $token_username!",
                        style: const TextStyle(
                          color: kButtonClr,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Text(
                        "Welcome Back!",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: kSubTextIconClr,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: size.width * 0.508,
                  ),
                  const ClipOval(
                    child: Image(
                        width: 40,
                        height: 40,
                        image: AssetImage('assets/images/profil.jpg'),
                        fit: BoxFit.cover),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    style: const TextStyle(color: kMainTextClr),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        filled: true,
                        fillColor: kBoxClr,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Search",
                        hintStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: kSubTextIconClr),
                        suffixIcon: const Icon(
                          Icons.search,
                          color: kSubTextIconClr,
                        ),
                        prefixIconColor: kSubTextIconClr),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        "Recent Documents",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: kSubTextIconClr),
                      ),
                      IconButton(
                        iconSize: 25,
                        onPressed: () {
                          setState(
                            () {
                              getDocuments();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Page Refreshed!"),
                                ),
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.refresh_rounded,
                          color: kSubTextIconClr,
                        ),
                        splashRadius: 25,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: getDocuments(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: (snapshot.data as dynamic)['data'].length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                    document: (snapshot.data as dynamic)['data']
                                        [index],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0),
                              child: Card(
                                elevation: 4,
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: SizedBox(
                                        width: 60,
                                        height: 60,
                                        child: Image.asset(
                                            "assets/images/document.png"),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 240,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  (snapshot.data
                                                          as dynamic)['data']
                                                      [index]['document_name'],
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    color: kMainTextClr,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  (snapshot.data as dynamic)[
                                                          'data'][index]
                                                      ['organization_name'],
                                                  maxLines: 2,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: kSubTextIconClr,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            children: const <Widget>[
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                color: kSubTextIconClr,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  } else {
                    return Container(
                      child: const Center(
                        child: Text(
                          "Waiting for Sever...",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: kSubTextIconClr),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kButtonClr,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
