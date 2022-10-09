import 'package:flutter/material.dart';
import 'package:kp_project/utilities/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAccountScreen extends StatefulWidget {
  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  String? token_id = "";
  String? token_fullName = "";
  String? token_email = "";
  String? token_title = "";
  String? token_phoneNumber = "";

  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      token_id = pref.getString("login_id");
      token_fullName = pref.getString("login_fullName");
      token_email = pref.getString("login_email");
      token_title = pref.getString("login_title");
      token_phoneNumber = pref.getString("login_phoneNumber");
    });
  }

  @override
  void initState() {
    super.initState();
    getCred();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kSubTextIconClr),
        centerTitle: true,
        title: const Text(
          "My Account",
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
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: <Widget>[
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 0),
                      )
                    ],
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                  ),
                  child: const ClipOval(
                    child: Image(
                        width: 180,
                        height: 180,
                        image: AssetImage('assets/images/profil.png'),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "PROFILE PICTURE",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: kSubTextIconClr),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Container(
                  width: size.width,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: kBoxClr),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        "NAME",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: kButtonClr),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        token_fullName!,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: kSubTextIconClr),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      const Text(
                        "EMAIL",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: kButtonClr),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        token_email!,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: kSubTextIconClr),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      const Text(
                        "TITLE",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: kButtonClr),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        token_title!,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: kSubTextIconClr),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      const Text(
                        "Phone Number",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: kButtonClr),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        token_phoneNumber!,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: kSubTextIconClr),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
