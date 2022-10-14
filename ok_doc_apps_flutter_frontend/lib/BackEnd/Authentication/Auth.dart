import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kp_project/FrontEnd/Screens/Home/home_screen.dart';
import 'package:kp_project/FrontEnd/Screens/Login/login_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

Future loginMethod(email, password, context) async {
  if (email.isNotEmpty && password.isNotEmpty) {
    var response = await http.post(
      Uri.parse("http://192.168.1.8:8000/api/login"),
      body: ({"email": email, "password": password}),
    );
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString("login_id", body["user"]["id"].toString());
      await pref.setString("login_username", body["user"]["username"]);
      await pref.setString("login_fullName", body["user"]["full_name"]);
      await pref.setString("login_email", body["user"]["email"]);
      await pref.setString("login_title", body["user"]["title"]);
      await pref.setString("login_phoneNumber", body["user"]["phone_number"]);

      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false);

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("You're Login!"),
          duration: Duration(seconds: 1),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid Username or Password"),
          duration: Duration(seconds: 1),
        ),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Insert Required Fields!"),
        duration: Duration(seconds: 1),
      ),
    );
  }
}

void checklogin(context) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? val = pref.getString("login_id");
  if (val != null) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false);
  } else {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false);
  }
}
