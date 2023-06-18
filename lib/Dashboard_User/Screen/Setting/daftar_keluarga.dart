import 'package:flutter/material.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/Screen/Pengajuan/pengajuan_surat.dart';
import 'package:mobile_kepuharjo_new/Model/Keluarga.dart';
import 'package:mobile_kepuharjo_new/Model/Surat.dart';
import 'package:mobile_kepuharjo_new/Resource/Mycolor.dart';
import 'package:mobile_kepuharjo_new/Resource/Myfont.dart';
import 'package:mobile_kepuharjo_new/Services/auth_services.dart';

class DaftarKeluargaUser extends StatefulWidget {
  const DaftarKeluargaUser({Key? key}) : super(key: key);

  @override
  State<DaftarKeluargaUser> createState() => _DaftarKeluargaUserState();
}

class _DaftarKeluargaUserState extends State<DaftarKeluargaUser> {
  AuthServices authServices = AuthServices();
  late Future<List<Keluarga>> listdata;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listdata = authServices.getMasyarakat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
          backgroundColor: white,
          shadowColor: Colors.transparent,
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: Text(
            "Daftar Keluarga",
            style: MyFont.poppins(
                fontSize: 14, color: black, fontWeight: FontWeight.bold),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(
                Icons.keyboard_arrow_left_rounded,
                color: black,
              ),
            ),
          )),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 500,
              child: FutureBuilder<List<Keluarga>>(
                future: listdata,
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    List<Keluarga>? data = snapshot.data;
                    return SizedBox(
                      child: ListView.builder(
                        itemCount: data!.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ListTile(
                                  leading: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: grey.withOpacity(0.1)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "images/group.png",
                                          height: 30,
                                          color: black,
                                        )
                                      ],
                                    ),
                                  ),
                                  title: Text(
                                    data[index]
                                        .masyarakat![index]
                                        .nik
                                        .toString(),
                                    style: MyFont.poppins(
                                        fontSize: 13,
                                        color: black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    data[index]
                                        .masyarakat![index]
                                        .namaLengkap
                                        .toString(),
                                    style: MyFont.poppins(
                                        fontSize: 12, color: black),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}