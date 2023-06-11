import 'package:flutter/material.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rt/Drawer/navigation_drawer.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rt/Drawer/select.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rt/Screen/Dashboard_Rt.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rt/Screen/Rekap_Pengajuan.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rt/Screen/Surat_Ditolak.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rt/Screen/Surat_Masuk.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rt/Screen/Surat_Selesai.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rt/Screen/Tentang.dart';
import 'package:mobile_kepuharjo_new/Model/User.dart';
import 'package:mobile_kepuharjo_new/Resource/Mycolor.dart';
import 'package:mobile_kepuharjo_new/Resource/Myfont.dart';
import 'package:mobile_kepuharjo_new/Services/auth_services.dart';
import 'package:provider/provider.dart';

class DashboardRT extends StatefulWidget {
  const DashboardRT({super.key});

  @override
  State<DashboardRT> createState() => _DashboardRTState();
}

class _DashboardRTState extends State<DashboardRT> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  AuthServices _authServices = AuthServices();
  User? _user;

  Future<void> _getUserData() async {
    try {
      final authServices = AuthServices();
      final user = await authServices.me();
      setState(() {
        _user = user;
      });
      print(_user?.masyarakat?.kks?.rt.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget getPage(int index) {
    switch (index) {
      case 0:
        return HomeRT();
      case 1:
        return SuratMasuk();
      case 2:
        return SuratDitolak();
      case 3:
        return SuratSelesai();
      case 4:
        return RekapPengajuan();
      case 5:
        return Tentang();
      default:
        return HomeRT();
    }
  }

  final authServices = AuthServices();

  int selectedIndex = 0;
  void onItemClicked(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  // Widget buildBody() {
  //   switch (selectedIndex) {
  //     case 0:
  //       return DashboarRtRw();
  //     case 1:
  //       return SuratMasuk();
  //     // add more cases for other screens
  //     default:
  //       return Center(
  //         child: Text('No page found for index $selectedIndex'),
  //       );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: white,
          shadowColor: Colors.transparent,
          title: Row(
            children: [
              Text(
                "S-Kepuharjo",
                style: MyFont.montserrat(
                    fontSize: 18, color: black, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          leading: InkWell(
            onTap: () {
              _openDrawer();
            },
            child: Icon(
              Icons.menu_rounded,
              color: black,
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
                  color: black,
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
