import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rt/home_rt.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/dashboard_user.dart';
import 'package:mobile_kepuharjo_new/Resource/Mycolor.dart';
import 'package:mobile_kepuharjo_new/Resource/Myfont.dart';
import 'package:mobile_kepuharjo_new/Wellcome/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoggedIn = false;
  String _userRole = '';
  void _checkIfLoggedIn() async {
    // check if token is there
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token != null) {
      var userJson = localStorage.getString('user');
      var role = localStorage.getString('role');
      var user = json.decode(userJson!);
      setState(() {
        _isLoggedIn = true;
        _userRole = role!;
      });
    }
  }

  Future<String> _getUserRole() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('role');
    return userJson.toString();
  }

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
    Timer(
      Duration(seconds: 3),
      () => _isLoggedIn
          ? _getUserRole().then((userRole) {
              Widget targetScreen;
              if (userRole == '4') {
                targetScreen = DashboardUser();
              } else if (userRole == '2') {
                // targetScreen = DashboardRT();
                targetScreen = DashboardRT();
              } else {
                targetScreen = OnboardingScreen();
              }
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => targetScreen),
              );
            })
          : Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => OnboardingScreen()),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Container(
        color: white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(" S-Kepuharjo",
                    style: MyFont.montserrat(
                        fontSize: 24,
                        color: black,
                        fontWeight: FontWeight.bold)),
                const SizedBox(
                  width: 5,
                ),
                Image.asset(
                  "images/mylogo.png",
                  height: 45,
                )
              ],
            ),
            const SizedBox(
              height: 70,
            ),
            SpinKitCircle(
              color: lavender,
              size: 35,
            )
          ],
        ),
      ),
    );
  }
}
