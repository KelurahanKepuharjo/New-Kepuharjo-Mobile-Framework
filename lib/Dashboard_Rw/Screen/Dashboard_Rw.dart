import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rt/Screen/widget_teks_dashboard.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rw/Screen/widget_card_Rw.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/Screen/Home/widget_berita.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/Screen/Home/widget_text_berita.dart';

class HomeRW extends StatefulWidget {
  const HomeRW({super.key});

  @override
  State<HomeRW> createState() => _HomeRWState();
}

class _HomeRWState extends State<HomeRW> {
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
              WidgetCardRw(),
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
