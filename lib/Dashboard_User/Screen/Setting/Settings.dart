import 'package:flutter/material.dart';
import 'package:mobile_kepuharjo_new/Model/User.dart';
import 'package:mobile_kepuharjo_new/Resource/Mycolor.dart';
import 'package:mobile_kepuharjo_new/Resource/Myfont.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
          backgroundColor: lavender,
          shadowColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: Text(
            "Pengaturan",
            style: MyFont.poppins(
                fontSize: 14, color: white, fontWeight: FontWeight.bold),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(
                Icons.keyboard_arrow_left_rounded,
                color: white,
              ),
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              height: 120,
              color: lavender,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    leading: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(100)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            user?.masyarakat?.namaLengkap ?? "",
                            style: MyFont.montserrat(
                                fontSize: 16,
                                color: black,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    title: Text(
                      "Achmad Fawaid",
                      style: MyFont.poppins(
                          fontSize: 14,
                          color: white,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "3509212504030001",
                      style: MyFont.poppins(
                          fontSize: 12,
                          color: white,
                          fontWeight: FontWeight.w500),
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_right_rounded,
                      color: white,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(
                Icons.person_outline_rounded,
                size: 25,
                color: black,
              ),
              title: Text(
                "Informasi Akun",
                style: MyFont.poppins(fontSize: 13, color: black),
              ),
            ),
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
                style: MyFont.poppins(fontSize: 13, color: black),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.people_outline_rounded,
                size: 25,
                color: black,
              ),
              title: Text(
                "Daftar Keluarga",
                style: MyFont.poppins(fontSize: 13, color: black),
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
                style: MyFont.poppins(fontSize: 13, color: black),
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
                style: MyFont.poppins(fontSize: 13, color: black),
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
                style: MyFont.poppins(fontSize: 13, color: black),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.help_outline_rounded,
                size: 25,
                color: black,
              ),
              title: Text(
                "Tentang",
                style: MyFont.poppins(fontSize: 13, color: black),
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 48,
              width: MediaQuery.of(context).size.width,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  primary: Colors.black, // Warna teks
                  backgroundColor: Colors.transparent, // Warna latar belakang
                  side: BorderSide(width: 1, color: lavender), // Border
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {},
                child: Text(
                  'Logout',
                  style: MyFont.poppins(fontSize: 14, color: lavender),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              "S-Kepuharjo\nversi 1.0.1",
              textAlign: TextAlign.center,
              style: MyFont.poppins(fontSize: 12, color: softgrey),
            )
          ],
        ),
      ),
    );
  }
}
