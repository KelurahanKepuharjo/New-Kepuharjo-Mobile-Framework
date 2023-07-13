import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rt/Drawer/navigation_drawer.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rw/Screen/widget_card_Rw.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/Screen/Home/widget_berita.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/Screen/Home/widget_text_berita.dart';
import 'package:mobile_kepuharjo_new/Model/Pengajuan.dart';
import 'package:mobile_kepuharjo_new/Resource/Mycolor.dart';
import 'package:mobile_kepuharjo_new/Services/api_services.dart';

import '../../Resource/Myfont.dart';

class BerandaRW extends StatefulWidget {
  const BerandaRW({super.key});

  @override
  State<BerandaRW> createState() => _BerandaRWState();
}

class _BerandaRWState extends State<BerandaRW> {
  Timer? _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getSuratMasuk();
    _getSuratDisetujui();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  bool select = true;
  int selectedIndex = 0;
  void onItemClicked(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<Pengajuan> pengajuan = [];
  List<Pengajuan> pengajuan1 = [];
  Future<void> _getSuratMasuk() async {
    final api = ApiServices();
    final surat = await api.getPengajuanRw("Disetujui RT");
    setState(() {
      pengajuan = surat;
    });
  }

  Future<void> _getSuratDisetujui() async {
    final api = ApiServices();
    final surat = await api.getPengajuanRw("Disetujui RW");
    setState(() {
      pengajuan1 = surat;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      drawer: CollapsingNavigationDrawer(
        selectedIndex: selectedIndex,
        onItemClicked: onItemClicked,
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            // title: Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: Row(
            //     children: [
            //       GestureDetector(
            //         onTap: () {
            //           _openDrawer();
            //         },
            //         child: Image.asset(
            //           "images/menu.png",
            //           color: white,
            //           height: 25,
            //         ),
            //       ),
            //       const SizedBox(
            //         width: 15,
            //       ),
            //       Text(
            //         "S-Kepuharjo",
            //         style: MyFont.montserrat(
            //             fontSize: 18,
            //             color: white,
            //             fontWeight: FontWeight.bold),
            //       ),
            //       const SizedBox(
            //         width: 5,
            //       ),
            //       Image.asset(
            //         "images/mylogo.png",
            //         width: 30,
            //         height: 30,
            //       ),
            //     ],
            //   ),
            // ),
            pinned: false,
            backgroundColor: primaryColor,
            shadowColor: Colors.transparent,
            expandedHeight: 180,
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(10),
                child: Container(
                  height: 15,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                )),
            flexibleSpace: FlexibleSpaceBar(
                background: Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 40),
              color: primaryColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                    child: Card(
                      elevation: 1, // tinggi bayangan
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 80,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${pengajuan.length}",
                                    style: MyFont.poppins(
                                        fontSize: 20,
                                        color: black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Surat Masuk",
                                    style: MyFont.poppins(
                                        fontSize: 12,
                                        color: black,
                                        fontWeight: FontWeight.normal),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              width: 1,
                              height: MediaQuery.of(context).size.height,
                              color: black.withOpacity(0.2),
                            ),
                            SizedBox(
                              height: 80,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${pengajuan1.length}",
                                    style: MyFont.poppins(
                                        fontSize: 20,
                                        color: black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Surat Disetujui",
                                    style: MyFont.poppins(
                                        fontSize: 12,
                                        color: black,
                                        fontWeight: FontWeight.normal),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                WidgetCardRw(),
                WidgetTextBerita(),
                WidgetBerita(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
