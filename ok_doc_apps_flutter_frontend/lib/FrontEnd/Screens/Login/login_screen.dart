import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kp_project/BackEnd/Authentication/Auth.dart';
import '../../../utilities/colors.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/images/main_top.png",
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "LOGIN",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: kLoginSignupTxtClr),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SvgPicture.asset(
                    "assets/icons/login.svg",
                    width: size.width * 0.7,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                      color: kLoginSignupFormClr,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      controller: emailController,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: kMainTextClr),
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: kButtonClr,
                        ),
                        hintText: "Your Email",
                        hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: kSubTextIconClr),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                      color: kLoginSignupFormClr,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      controller: passwordController,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: kMainTextClr),
                      obscureText: isHidden,
                      decoration: InputDecoration(
                          icon: const Icon(
                            Icons.lock,
                            color: kButtonClr,
                          ),
                          suffixIcon: IconButton(
                            splashColor: Colors.transparent,
                            icon: isHidden
                                ? const Icon(
                                    Icons.visibility_off,
                                    color: kButtonClr,
                                  )
                                : const Icon(
                                    Icons.visibility,
                                    color: kButtonClr,
                                  ),
                            onPressed: togglePasswordVisibility,
                          ),
                          hintText: "Password",
                          hintStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: kSubTextIconClr),
                          border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: size.width * 0.8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: MaterialButton(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        color: kButtonClr,
                        onPressed: () {
                          loginMethod(emailController.text,
                              passwordController.text, context);
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: kButtonTextClr),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: size.width * 0.7,
                    child: const Text(
                      "Tracking your company document's history anywhere and anytime",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: kLoginSignupSubTxtClr),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);
}
