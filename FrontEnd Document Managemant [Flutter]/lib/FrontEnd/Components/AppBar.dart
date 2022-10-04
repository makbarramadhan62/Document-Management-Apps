import 'package:flutter/material.dart';
import 'package:kp_project/utilities/colors.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  const CustomAppBar({
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(0),
          ),
          child: Row(
            children: <Widget>[
              const BackButton(),
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: kMainTextClr,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
