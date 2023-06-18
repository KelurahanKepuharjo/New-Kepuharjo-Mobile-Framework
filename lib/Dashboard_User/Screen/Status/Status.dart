import 'package:flutter/material.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/Screen/Status/TabBarView/surat_diajukan.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/Screen/Status/TabBarView/surat_dibatalkan.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/Screen/Status/TabBarView/surat_diproses.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/Screen/Status/TabBarView/surat_ditolak.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/Screen/Status/TabBarView/surat_selesai.dart';
import 'package:mobile_kepuharjo_new/Resource/Mycolor.dart';
import 'package:mobile_kepuharjo_new/Resource/Myfont.dart';

class Status extends StatefulWidget {
  const Status({super.key});

  @override
  State<Status> createState() => _StatusState();
}

class _StatusState extends State<Status> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          // backgroundColor: black,
          appBar: AppBar(
            backgroundColor: white,
            shadowColor: Colors.transparent,
            automaticallyImplyLeading: false,
            title: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "Status Surat",
                style: MyFont.poppins(
                    fontSize: 16, color: black, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            child: Column(
              children: [
                Container(
                  color: white,
                  margin: const EdgeInsets.all(0),
                  child: TabBar(
                      unselectedLabelColor: grey,
                      labelColor: primaryColor,
                      labelStyle: MyFont.poppins(
                          fontSize: 12,
                          color: black,
                          fontWeight: FontWeight.bold),
                      unselectedLabelStyle: MyFont.poppins(
                          fontSize: 12,
                          color: grey,
                          fontWeight: FontWeight.w500),
                      isScrollable: true,
                      indicatorColor: primaryColor,
                      tabs: const [
                        Tab(text: "Surat Diajukan"),
                        Tab(text: "Surat Diporoses"),
                        Tab(text: "Surat Selesai"),
                        Tab(text: "Surat Ditolak"),
                      ]),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TabBarView(children: [
                    SizedBox(
                      child: Column(
                        children: [SuratDiajukanUser()],
                      ),
                    ),
                    SizedBox(
                      child: Column(
                        children: [SuratDiprosesUser()],
                      ),
                    ),
                    SizedBox(
                      child: Column(
                        children: [SuratSelesaiUser()],
                      ),
                    ),
                    SizedBox(
                      child: Column(
                        children: [SuratDitolakUser()],
                      ),
                    ),
                  ]),
                ))
              ],
            ),
          )),
    );
  }
}
