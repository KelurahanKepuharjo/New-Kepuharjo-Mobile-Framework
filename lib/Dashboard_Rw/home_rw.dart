import 'package:flutter/material.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rw/Drawer/navigation_drawer.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rt/Drawer/select.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rt/Screen/Tentang.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rw/Screen/Dashboard_Rw.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rw/Screen/Rekap_Pengajuan_Rw.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rw/Screen/Surat_Masuk_Rw.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rw/Screen/Surat_Selesai_Rw.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rw/Screen/beranda_rw.dart';
import 'package:mobile_kepuharjo_new/Resource/Mycolor.dart';
import 'package:mobile_kepuharjo_new/Resource/Myfont.dart';
import 'package:mobile_kepuharjo_new/Services/api_services.dart';
import 'package:mobile_kepuharjo_new/Services/auth_services.dart';
import 'package:provider/provider.dart';

class DashboardRW extends StatefulWidget {
  const DashboardRW({super.key});

  @override
  State<DashboardRW> createState() => _DashboardRWState();
}

class _DashboardRWState extends State<DashboardRW> {
  final GlobalKey<ScaffoldState> _scaffoldKeyRw = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKeyRw.currentState?.openDrawer();
  }

  Future<void> initCheck() async {
    await apiServices.check();
  }

  ApiServices apiServices = ApiServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initCheck();
  }

  Widget getPage(int index) {
    switch (index) {
      case 0:
        return BerandaRW();
      case 1:
        return SuratMasukRw();
      case 2:
        return SuratSelesaiRw();
      case 3:
        return RekapPengajuanRw();
      case 4:
        return Tentang();
      default:
        return HomeRW();
    }
  }

  final authServices = AuthServices();

  int selectedIndex = 0;
  void onItemClicked(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKeyRw,
        backgroundColor: white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: primaryColor,
          shadowColor: Colors.transparent,
          title: Row(
            children: [
              Text(
                "S-Kepuharjo",
                style: MyFont.montserrat(
                    fontSize: 18, color: white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          leading: InkWell(
            onTap: () {
              _openDrawer();
            },
            child: Icon(
              Icons.menu_rounded,
              color: white,
            ),
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
                                  Icons.info_outline,
                                  color: blue,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Info Aplikasi",
                                  style: MyFont.poppins(
                                      fontSize: 12, color: black),
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
                                  style: MyFont.poppins(
                                      fontSize: 12, color: black),
                                ),
                              ],
                            )),
                      ]).then((value) {
                    if (value != null) {
                      if (value == 1) {
                        authServices.logout(context);
                      } else {}
                    }
                  });
                },
                icon: Icon(
                  Icons.more_vert,
                  color: white,
                ),
              ),
            ),
          ],
        ),
        drawer: CollapsingNavigationDrawer(
          selectedIndex: selectedIndex,
          onItemClicked: onItemClicked,
        ),
        body: Consumer<SelectedPage>(
          builder: (context, selectedPage, child) {
            return getPage(selectedPage.selectedIndex);
          },
        ));
  }
}
