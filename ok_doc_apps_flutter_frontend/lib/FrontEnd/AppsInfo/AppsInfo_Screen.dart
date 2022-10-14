import 'package:flutter/material.dart';
import 'package:kp_project/utilities/colors.dart';

class AppsInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kSubTextIconClr),
        centerTitle: true,
        title: const Text(
          "Apps Info",
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
          padding: EdgeInsets.only(top: size.height * 0.15),
          child: Column(children: [
            const Text(
              "Otak Kanan Document",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: kMainTextClr,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Versi 1.0",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: kSubTextIconClr,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Image.asset(
              'assets/images/logo.png',
              width: 250,
              height: 250,
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Icon(
                  Icons.copyright_outlined,
                  color: kSubTextIconClr,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "2022 Otak Kanan",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: kSubTextIconClr,
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
