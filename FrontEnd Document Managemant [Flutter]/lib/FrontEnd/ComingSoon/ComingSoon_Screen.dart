import 'package:flutter/material.dart';
import 'package:kp_project/utilities/colors.dart';

class ComingSoon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kSubTextIconClr),
        centerTitle: true,
        title: const Text(
          "Document Management",
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Center(
                child: Text(
                  "COMING SOON",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: kSubTextIconClr,
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
