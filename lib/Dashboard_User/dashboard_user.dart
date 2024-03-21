import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/Screen/Home/home_user.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/Screen/Pengajuan/daftar_pelayanan.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/Screen/Setting/Settings.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/Screen/Status/Status.dart';
import 'package:mobile_kepuharjo_new/Resource/Mycolor.dart';
import 'package:mobile_kepuharjo_new/Resource/Myfont.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardUser extends StatefulWidget {
  const DashboardUser({super.key});

  @override
  State<DashboardUser> createState() => _DashboardUserState();
}

class _DashboardUserState extends State<DashboardUser> {
  var userData;
  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson!);
    setState(() {
      userData = user;
    });
  }

  int index = 0;
  List<Widget> screen = <Widget>[
    const HomeUser(),
    const Layanan(),
    const Status(),
    const Pengaturan(),
  ];
  late PermissionStatus _notificationStatus;
  late PermissionStatus _storageStatus;

  Future<void> requestPermissions() async {
    // Request notification permission
    final notificationStatus = await Permission.notification.request();
    setState(() {
      _notificationStatus = notificationStatus;
    });

    // Request external storage permission
    final storageStatus = await Permission.storage.request();
    setState(() {
      _storageStatus = storageStatus;
    });
  }

  List navbutton = [
    {
      "active_icon": Image.asset(
        "images/beranda.png",
        height: 20,
        color: tPrimary,
      ),
      "non_active_icon": Image.asset(
        "images/beranda.png",
        height: 20,
        color: softgrey,
      ),
      "label": "Home"
    },
    {
      "active_icon": Image.asset(
        "images/email.png",
        height: 20,
        color: tPrimary,
      ),
      "non_active_icon": Image.asset(
        "images/email.png",
        height: 20,
        color: softgrey,
      ),
      "label": "Pengajuan"
    },
    {
      "active_icon": Image.asset(
        "images/clipboard.png",
        height: 20,
        color: tPrimary,
      ),
      "non_active_icon": Image.asset(
        "images/clipboard.png",
        height: 20,
        color: softgrey,
      ),
      "label": "Status"
    },
    {
      "active_icon": Image.asset(
        "images/account.png",
        height: 25,
        color: tPrimary,
      ),
      "non_active_icon": Image.asset(
        "images/account.png",
        height: 25,
        color: softgrey,
      ),
      "label": "Profil"
    },
  ];
  void onTap(value) {
    setState(() {
      index = value;
      // _currentUser.getUserInfo();
      _getUserInfo();
      print(userData);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: screen[index],
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: true,
          unselectedLabelStyle: MyFont.poppins(
              fontSize: 12, color: grey, fontWeight: FontWeight.w300),
          selectedLabelStyle: MyFont.poppins(
              fontSize: 12, color: white, fontWeight: FontWeight.w500),
          selectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          selectedItemColor: tPrimary,
          unselectedItemColor: softgrey,
          currentIndex: index,
          onTap: onTap,
          elevation: 0,
          backgroundColor: Colors.white,
          items: List.generate(4, (index) {
            var navBtn = navbutton[index];
            return BottomNavigationBarItem(
                icon: navBtn["non_active_icon"],
                activeIcon: navBtn["active_icon"],
                label: navBtn["label"]);
          })),
    );
  }
}
