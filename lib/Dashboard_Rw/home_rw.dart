import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rw/Drawer/navigation_drawer.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rt/Drawer/select.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rt/Screen/Tentang.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rw/Screen/Rekap_Pengajuan_Rw.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rw/Screen/Surat_Masuk_Rw.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rw/Screen/Surat_Selesai_Rw.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rw/Screen/beranda_rw.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/Screen/Setting/info_aplikasi.dart';
import 'package:mobile_kepuharjo_new/Resource/Mycolor.dart';
import 'package:mobile_kepuharjo_new/Resource/Myfont.dart';
import 'package:mobile_kepuharjo_new/Services/auth_services.dart';
import 'package:permission_handler/permission_handler.dart';
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
        return BerandaRW();
    }
  }

  final authServices = AuthServices();

  int selectedIndex = 0;
  void onItemClicked(int index) {
    setState(() {
      selectedIndex = index;
    });
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestPermissions();
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
                "S-Tompokersan",
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
              builder: (context) => const DashboardRW(),
            ),
            (route) => false);
      },
      btnCancelIcon: Icons.highlight_off_rounded,
      btnOkIcon: Icons.task_alt_rounded,
    ).show();
  }
}
