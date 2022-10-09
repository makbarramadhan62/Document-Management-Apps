import 'package:flutter/material.dart';
import 'package:kp_project/BackEnd/API/ApiConf.dart';
import 'package:kp_project/FrontEnd/Models/document.dart';
import 'package:kp_project/FrontEnd/Screens/EditDocument/edit_screen.dart';
import 'package:kp_project/FrontEnd/Screens/Home/home_screen.dart';
import 'package:kp_project/utilities/colors.dart';

class DetailScreen extends StatefulWidget {
  final Document document;
  const DetailScreen({required this.document});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool tappedYes = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kSubTextIconClr),
        centerTitle: true,
        title: const Text(
          "Document's Detail",
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
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 100,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color: kButtonClr,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Text(
                                      "PDF",
                                      style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          color: kPrimaryClr),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    widget.document.file_upload,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: kSubTextIconClr),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: const <Widget>[
                          Text(
                            "About Document",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: kSubTextIconClr),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: size.width,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kBoxClr),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                const Expanded(
                                  child: Text(
                                    "Owner",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: kMainTextClr),
                                  ),
                                ),
                                Text(
                                  widget.document.username,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: kMainTextClr),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                const Expanded(
                                  child: Text(
                                    "Document Name",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: kMainTextClr),
                                  ),
                                ),
                                Text(
                                  widget.document.document_name,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: kMainTextClr),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                const Expanded(
                                  child: Text(
                                    "Organization Name",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: kMainTextClr),
                                  ),
                                ),
                                Text(
                                  widget.document.organization_name,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: kMainTextClr),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                const Expanded(
                                  child: Text(
                                    "Date",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: kMainTextClr),
                                  ),
                                ),
                                Text(
                                  widget.document.date,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: kMainTextClr),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: const <Widget>[
                          Text(
                            "Status",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: kSubTextIconClr),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: size.width,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kBoxClr),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            if (widget.document.status_id == '1')
                              Row(
                                children: const <Widget>[
                                  Icon(Icons.circle,
                                      size: 10, color: KTypeInClr),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Validated",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: KTypeInClr),
                                  ),
                                ],
                              ),
                            if (widget.document.status_id == '2')
                              Row(
                                children: const <Widget>[
                                  Icon(Icons.circle,
                                      size: 10, color: kDangerClr),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "UnValidated",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: kDangerClr),
                                  ),
                                ],
                              ),
                            if (widget.document.status_id == '3')
                              Row(
                                children: const <Widget>[
                                  Icon(Icons.circle,
                                      size: 10, color: kDangerClr),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Depreceated",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: kDangerClr),
                                  ),
                                ],
                              ),
                            if (widget.document.type_id == '1')
                              Row(
                                children: const <Widget>[
                                  Icon(
                                    Icons.circle,
                                    size: 10,
                                    color: KTypeInClr,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Document In",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: KTypeInClr),
                                  ),
                                ],
                              ),
                            if (widget.document.type_id == '2')
                              Row(
                                children: const <Widget>[
                                  Icon(
                                    Icons.circle,
                                    size: 10,
                                    color: kDangerClr,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Document Out",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: kDangerClr),
                                  ),
                                ],
                              ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.circle,
                                  size: 10,
                                  color: KCtgryClr,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  widget.document.category_name,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: KCtgryClr),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: MaterialButton(
                              minWidth: 120,
                              height: 50,
                              color: kButtonClr,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditScreen(
                                      document: widget.document,
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                "Edit",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: kButtonTextClr),
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: MaterialButton(
                              minWidth: 120,
                              height: 50,
                              color: kDangerClr,
                              onPressed: () async {
                                final action =
                                    await AlertDialogs.yesCancelDialog(
                                        context, 'Delete', 'are you sure?');
                                if (action == DialogsAction.yes) {
                                  setState(() => tappedYes = true);
                                  deleteDocument(widget.document.id.toString())
                                      .then(
                                    (value) {
                                      setState(() {});
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen()),
                                          (route) => false);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text("Document Deleted!"),
                                          duration: Duration(seconds: 1),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  setState(() => tappedYes = false);
                                }
                              },
                              child: const Text(
                                "Delete",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: kButtonTextClr),
                              ),
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
    );
  }
}
