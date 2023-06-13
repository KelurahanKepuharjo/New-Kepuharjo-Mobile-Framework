import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rt/Screen/widget_card.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rt/Screen/widget_teks_dashboard.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/Screen/Home/widget_berita.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/Screen/Home/widget_text_berita.dart';
import 'package:mobile_kepuharjo_new/Services/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRT extends StatefulWidget {
  const HomeRT({super.key});

  @override
  State<HomeRT> createState() => _HomeRTState();
}

class _HomeRTState extends State<HomeRT> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color.fromARGB(255, 248, 248, 248),
        // drawer: CollapsingNavigationDrawer(),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              WidgetTextDashboard(),
              WidgetCard(),
              WidgetTextBerita(),
              WidgetBerita(),
              SizedBox(
                height: 30,
              )
            ],
          ),
        )));
  }
}