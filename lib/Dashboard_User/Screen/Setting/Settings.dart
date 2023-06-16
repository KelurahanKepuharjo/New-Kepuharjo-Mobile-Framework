import 'package:flutter/material.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/dashboard_user.dart';
import 'package:mobile_kepuharjo_new/Model/User.dart';
import 'package:mobile_kepuharjo_new/Resource/Mycolor.dart';
import 'package:mobile_kepuharjo_new/Resource/Myfont.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:mobile_kepuharjo_new/Services/auth_services.dart';

class Pengaturan extends StatefulWidget {
  const Pengaturan({super.key});

  @override
  State<Pengaturan> createState() => _PengaturanState();
}

class _PengaturanState extends State<Pengaturan> {
  // AuthServices authServices = AuthServices();
  User? user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  Future<void> getUser() async {
    final authServices = AuthServices();
    final auth = await authServices.me();
    if (auth != null) {
      setState(() {
        user = auth;
      });
    }
  }

  final authServices = AuthServices();
  showSuccessDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.WARNING,
      title: 'Warning!',
      titleTextStyle: MyFont.poppins(
          fontSize: 25, color: lavender, fontWeight: FontWeight.bold),
      desc: 'Apakah anda yakin, untuk Keluar dari aplikasi',
      descTextStyle: MyFont.poppins(fontSize: 12, color: softgrey),
      btnOkOnPress: () {
        authServices.logout(context);
      },
      btnCancelOnPress: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const DashboardUser(),
            ),
            (route) => false);
      },
      btnCancelIcon: Icons.highlight_off_rounded,
      btnOkIcon: Icons.task_alt_rounded,
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundGrey,
      appBar: AppBar(
        backgroundColor: white,
        shadowColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Text(
            "Profil",
            style: MyFont.poppins(
                fontSize: 20, color: black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        // padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              color: white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: 65,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(width: 1, color: softgrey)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: lavender,
                              borderRadius: BorderRadius.circular(100)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                user?.masyarakat?.namaLengkap!
                                        .substring(0, 2)
                                        .toUpperCase() ??
                                    "",
                                style: MyFont.montserrat(
                                    fontSize: 16,
                                    color: white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user?.masyarakat?.namaLengkap ?? "",
                              style: MyFont.poppins(
                                  fontSize: 14,
                                  color: black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              user?.masyarakat?.nik.toString() ?? "",
                              style: MyFont.poppins(
                                  fontSize: 12,
                                  color: black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 5),
                    child: Text(
                      "Akun",
                      textAlign: TextAlign.start,
                      style: MyFont.poppins(
                          fontSize: 14,
                          color: black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.person_outline_rounded,
                      size: 25,
                      color: black,
                    ),
                    title: Text(
                      "Informasi Akun",
                      style: MyFont.poppins(fontSize: 12, color: black),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => UbahNomerHandphone(),
                      //     ));
                    },
                    leading: Icon(
                      Icons.phonelink_setup_rounded,
                      size: 25,
                      color: black,
                    ),
                    title: Text(
                      "Ubah Nomer Telepon",
                      style: MyFont.poppins(fontSize: 12, color: black),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.people_outline_rounded,
                      size: 25,
                      color: black,
                    ),
                    title: Text(
                      "Daftar Keluarga",
                      style: MyFont.poppins(fontSize: 12, color: black),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: EdgeInsets.all(8),
              color: white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 15),
                    child: Text(
                      "Lokasi",
                      textAlign: TextAlign.start,
                      style: MyFont.poppins(
                          fontSize: 14,
                          color: black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.location_on_outlined,
                      size: 25,
                      color: black,
                    ),
                    title: Text(
                      "Lokasi Kelurahan",
                      style: MyFont.poppins(fontSize: 12, color: black),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: EdgeInsets.all(8),
              color: white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 15),
                    child: Text(
                      "Surat",
                      textAlign: TextAlign.start,
                      style: MyFont.poppins(
                          fontSize: 14,
                          color: black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.markunread_outlined,
                      size: 25,
                      color: black,
                    ),
                    title: Text(
                      "Surat Dibatalakan",
                      style: MyFont.poppins(fontSize: 12, color: black),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              color: white,
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 15),
                    child: Text(
                      "Tentang",
                      textAlign: TextAlign.start,
                      style: MyFont.poppins(
                          fontSize: 14,
                          color: black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.info_outline_rounded,
                      size: 25,
                      color: black,
                    ),
                    title: Text(
                      "Info Aplikasi",
                      style: MyFont.poppins(fontSize: 12, color: black),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.help_outline_rounded,
                      size: 25,
                      color: black,
                    ),
                    title: Text(
                      "Tentang",
                      style: MyFont.poppins(fontSize: 12, color: black),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 48,
              width: MediaQuery.of(context).size.width,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  primary: Colors.black, // Warna teks
                  backgroundColor: lavender, // Warna latar belakang
                  // side: BorderSide(width: 1, color: lavender), // Border
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () {
                  showSuccessDialog(context);
                },
                child: Text(
                  'Logout',
                  style: MyFont.poppins(fontSize: 14, color: white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "S-Kepuharjo\nversi 1.0.1",
                  textAlign: TextAlign.center,
                  style: MyFont.poppins(fontSize: 12, color: softgrey),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
