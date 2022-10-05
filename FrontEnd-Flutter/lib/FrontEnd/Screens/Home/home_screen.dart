import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kp_project/BackEnd/API/ApiConf.dart';
import 'package:kp_project/FrontEnd/Models/document.dart';
import 'package:kp_project/FrontEnd/Screens/AddDocument/add_screen.dart';
import 'package:kp_project/FrontEnd/Screens/DetailDocument/detail_screen.dart';
import 'package:kp_project/FrontEnd/Screens/Home/Widget/SideBar.dart';
import 'package:kp_project/utilities/colors.dart';
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

class Debouncer {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
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

  final _debouncer = Debouncer(milliseconds: 500);
  List<Document> documents = [];
  List<Document> searchDocuments = [];

  @override
  void initState() {
    super.initState();
    ServicesGetApi.getDocuments().then((documentsFromServer) {
      setState(() {
        documents = documentsFromServer;
        searchDocuments = documents;
      });
    });
    getCred();
  }

  @override
  Widget build(BuildContext context) {
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
                        image: AssetImage('assets/images/profil1.png'),
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
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: kMainTextClr),
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
                      prefixIconColor: kSubTextIconClr,
                    ),
                    onChanged: (string) {
                      _debouncer.run(() {
                        setState(() {
                          searchDocuments = documents
                              .where((query) => (query.document_name
                                      .toLowerCase()
                                      .contains(string.toLowerCase()) ||
                                  query.organization_name
                                      .toLowerCase()
                                      .contains(string.toLowerCase())))
                              .toList();
                        });
                      });
                    },
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
              child: ListView.builder(
                itemCount: searchDocuments.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            document: searchDocuments[index],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                      child: Card(
                        elevation: 4,
                        shadowColor: Colors.grey[200],
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: SizedBox(
                                width: 60,
                                height: 60,
                                child: Image.asset("assets/icons/document.png"),
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
                                          searchDocuments[index].document_name,
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
                                          searchDocuments[index]
                                              .organization_name,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: kSubTextIconClr,
                                              fontWeight: FontWeight.w500),
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
