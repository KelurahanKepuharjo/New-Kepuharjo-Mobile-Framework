import 'package:flutter/material.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rt/Drawer/navigation_drawer.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rt/Drawer/select.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rt/Screen/Rekap_Pengajuan.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rt/Screen/Surat_Ditolak.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rt/Screen/Surat_Masuk.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rt/Screen/Surat_Selesai.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rt/Screen/Tentang.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rt/Screen/beranda_rt.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/Screen/Setting/info_aplikasi.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_kepuharjo_new/Resource/Mycolor.dart';
import 'package:mobile_kepuharjo_new/Resource/Myfont.dart';
import 'package:mobile_kepuharjo_new/Services/auth_services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

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


  Widget getPage(int index) {
    switch (index) {
      case 0:
        return BerandaRT();
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
        return BerandaRT();
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
  void initState() {
    // TODO: implement initState
    super.initState();
    requestPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: primaryColor,
          shadowColor: Colors.transparent,
          title: Row(
            children: [
              Row(
                children: [
                  Text(
                    "S-Kepuharjo",
                    style: MyFont.montserrat(
                        fontSize: 18,
                        color: white,
                        fontWeight: FontWeight.bold),
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
            ],
          ),
          leading: InkWell(
            onTap: () {
              _openDrawer();
            },
            child: Icon(
              Icons.menu,
              color: white,
              // size: 30,
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
                        showSuccessDialog(context);
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InfoAplikasi(),
                            ));
                      }
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

  showSuccessDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.WARNING,
      title: 'Warning!',
      titleTextStyle: MyFont.poppins(
          fontSize: 25, color: primaryColor, fontWeight: FontWeight.bold),
      desc: 'Apakah anda yakin, untuk Keluar dari aplikasi',
      descTextStyle: MyFont.poppins(fontSize: 12, color: softgrey),
      btnOkOnPress: () {
        authServices.logout(context);
        Fluttertoast.showToast(
            msg: "Berhasil keluar dari aplikasi",
            backgroundColor: black.withOpacity(0.7));
      },
      btnCancelOnPress: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const DashboardRT(),
            ),
            (route) => false);
      },
      btnCancelIcon: Icons.highlight_off_rounded,
      btnOkIcon: Icons.task_alt_rounded,
    ).show();
  }
}
