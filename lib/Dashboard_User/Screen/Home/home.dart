import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/Screen/Home/widget_category.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/Screen/Setting/Settings.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/dashboard_user.dart';
import 'package:mobile_kepuharjo_new/Resource/Mycolor.dart';
import 'package:mobile_kepuharjo_new/Resource/Myfont.dart';
import 'package:mobile_kepuharjo_new/Services/auth_services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Timer? _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        select = !select;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _timer?.cancel();
  }

  bool select = true;
  final authServices = AuthServices();
  showSuccessDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.WARNING,
      title: 'Warning!',
      titleTextStyle: MyFont.poppins(
          fontSize: 25, color: lavender, fontWeight: FontWeight.bold),
      desc: 'Apakah anda yakin, untuk Keluar dari aplikasi',
      descTextStyle: MyFont.poppins(fontSize: 12, color: softgrey),
      btnOkOnPress: () {
        authServices.logout(context);
      },
      btnCancelOnPress: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const DashboardUser(),
            ),
            (route) => false);
      },
      btnCancelIcon: Icons.highlight_off_rounded,
      btnOkIcon: Icons.task_alt_rounded,
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.transparent,
        backgroundColor: white,
        title: Row(
          children: [
            Text(
              "S-Kepuharjo",
              style: MyFont.montserrat(
                  fontSize: 18, color: black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 5,
            ),
            Image.asset(
              "images/mylogo.png",
              width: 30,
              height: 30,
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: IconButton(
              onPressed: () {
                showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(
                        MediaQuery.of(context).size.width - 50, // right
                        50,
                        0,
                        0),
                    items: [
                      PopupMenuItem<int>(
                          value: 0,
                          child: Row(
                            children: [
                              Icon(
                                Icons.settings,
                                color: blue,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Pengaturan",
                                style:
                                    MyFont.poppins(fontSize: 12, color: black),
                              ),
                            ],
                          )),
                      PopupMenuItem<int>(
                          value: 1,
                          child: Row(
                            children: [
                              Icon(
                                Icons.logout_rounded,
                                color: blue,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Logout",
                                style:
                                    MyFont.poppins(fontSize: 12, color: black),
                              ),
                            ],
                          )),
                    ]).then((value) {
                  if (value != null) {
                    if (value == 1) {
                      showSuccessDialog(context);
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Pengaturan(),
                          ));
                    }
                  }
                });
              },
              icon: Icon(
                Icons.more_vert,
                color: black,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.only(bottom: 0),
        height: MediaQuery.of(context).size.height * 0.9,
        child: Stack(
          children: [
            Container(),
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                image: const DecorationImage(
                    image: AssetImage("images/kab.jpeg"), fit: BoxFit.cover),
              ),
              child: AnimatedContainer(
                duration: Duration(seconds: 1),
                color:
                    select ? Colors.transparent : Colors.black.withOpacity(0.5),
                padding: EdgeInsets.fromLTRB(25, 25, 25, 15),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    select
                        ? AnimatedDefaultTextStyle(
                            style: MyFont.inter(fontSize: 18, color: white),
                            duration: Duration(seconds: 2),
                            child: Text(""))
                        : Padding(
                            padding: const EdgeInsets.only(top: 10, left: 8),
                            child: AnimatedDefaultTextStyle(
                                curve: Curves.slowMiddle,
                                style: MyFont.poppins(
                                    fontSize: 18,
                                    color: white,
                                    fontWeight: FontWeight.bold),
                                duration: Duration(seconds: 2),
                                child: Text(
                                  "Profil Kelurahan",
                                  style: MyFont.poppins(
                                      fontSize: 18,
                                      color: white,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                    select
                        ? AnimatedDefaultTextStyle(
                            style: MyFont.inter(fontSize: 18, color: white),
                            duration: Duration(seconds: 2),
                            child: Text(""))
                        : Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 10),
                            child: AnimatedDefaultTextStyle(
                              curve: Curves.slowMiddle,
                              style: MyFont.poppins(
                                fontSize: 11,
                                color: white,
                              ),
                              duration: Duration(seconds: 2),
                              child: Text(
                                "Kel. Kepuharjo, Kec. Lumajang, Kab. Lumajang",
                                style:
                                    MyFont.poppins(fontSize: 11, color: white),
                              ),
                            ),
                          ),
                    select
                        ? AnimatedDefaultTextStyle(
                            style: MyFont.inter(fontSize: 18, color: white),
                            duration: Duration(seconds: 2),
                            child: Text(""))
                        : Container(
                            margin: EdgeInsets.only(left: 8),
                            height: 35,
                            width: 80,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: lavender.withOpacity(0.9),
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  )),
                              onPressed: () async {
                                // isLoading ? null : verifyLogin();
                              },
                              child: Text('Profil',
                                  style: MyFont.poppins(
                                      fontSize: 11, color: white)),
                            ),
                          )
                  ],
                ),
              ),
            ),
            const Positioned(
                top: 160,
                bottom: 0,
                right: 0,
                left: 0,
                child: CategoriesWidget()),
          ],
        ),
      )),
    );
  }
}
