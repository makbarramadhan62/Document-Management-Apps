import 'package:flutter/material.dart';
import 'package:kp_project/FrontEnd/ComingSoon/ComingSoon_Screen.dart';
import 'package:kp_project/FrontEnd/Screens/Home/home_screen.dart';
import 'package:kp_project/FrontEnd/Screens/Login/login_screen.dart';
import 'package:kp_project/FrontEnd/Screens/MyAccount/myAccount_screen.dart';
import 'package:kp_project/utilities/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideBar extends StatefulWidget {
  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  String? token_id = "";
  String? token_username = "";
  String? token_email = "";

  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      token_id = pref.getString("login_id");
      token_username = pref.getString("login_username");
      token_email = pref.getString("login_email");
    });
  }

  @override
  void initState() {
    super.initState();
    getCred();
  }

  final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: kPrimaryClr,
        child: ListView(
          children: <Widget>[
            Container(
              padding: padding.add(
                EdgeInsets.symmetric(vertical: 40),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/profil1.png'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    token_username!,
                    style: const TextStyle(fontSize: 24, color: kButtonClr),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    token_email!,
                    style: TextStyle(fontSize: 14, color: kSubTextIconClr),
                  ),
                ],
              ),
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  buildMenuItem(
                    text: 'My Account',
                    icon: Icons.person_outline,
                    onClicked: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MyAccountScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'History',
                    icon: Icons.history,
                    onClicked: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ComingSoon(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Help',
                    icon: Icons.help_outline,
                    onClicked: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ComingSoon(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  const Divider(
                    thickness: 1,
                  ),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Settings',
                    icon: Icons.settings,
                    onClicked: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ComingSoon(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Logout',
                    icon: Icons.logout,
                    onClicked: () async {
                      bool tappedYes = false;
                      final action = await AlertDialogs.yesCancelDialog(
                          context, 'Logout', 'are you sure ?');
                      if (action == DialogsAction.yes) {
                        setState(() => tappedYes = true);
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        await pref.clear();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                            (route) => false);
                      } else {
                        setState(() => tappedYes = false);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: kSubTextIconClr),
      title: Text(text, style: TextStyle(color: kButtonClr)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
}
