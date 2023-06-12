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
          backgroundColor: backgroundGrey,
          appBar: AppBar(
            backgroundColor: lavender,
            shadowColor: Colors.transparent,
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Text(
              "Status Surat",
              style: MyFont.poppins(
                  fontSize: 16, color: white, fontWeight: FontWeight.bold),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              children: [
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade300,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: TabBar(
                        unselectedLabelColor: Colors.black,
                        labelColor: Colors.white,
                        labelStyle: MyFont.poppins(fontSize: 12, color: black),
                        isScrollable: true,
                        indicator: BoxDecoration(
                          color: lavender,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        tabs: const [
                          Tab(text: "Surat Diajukan"),
                          Tab(text: "Surat Diporoses"),
                          Tab(text: "Surat Selesai"),
                          Tab(text: "Surat Ditolak"),
                        ]),
                  ),
                ),
                Expanded(
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
                ]))
              ],
            ),
          )),
    );
  }
}
