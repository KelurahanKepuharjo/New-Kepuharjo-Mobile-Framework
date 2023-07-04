import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/Screen/Status/detail_surat.dart';
import 'package:mobile_kepuharjo_new/Model/Pengajuan.dart';
import 'package:mobile_kepuharjo_new/Model/User.dart';
import 'package:mobile_kepuharjo_new/Resource/Mycolor.dart';
import 'package:mobile_kepuharjo_new/Resource/Myfont.dart';
import 'package:mobile_kepuharjo_new/Services/api_connect.dart';
import 'package:mobile_kepuharjo_new/Services/api_services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mobile_kepuharjo_new/Services/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuratDiajukanUser extends StatefulWidget {
  const SuratDiajukanUser({super.key});

  @override
  State<SuratDiajukanUser> createState() => _SuratDiajukanUserState();
}

class _SuratDiajukanUserState extends State<SuratDiajukanUser>
    with SingleTickerProviderStateMixin {
  ApiServices apiServices = ApiServices();
  late Future<List<Pengajuan>> listdata;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listdata = apiServices.getStatus("Diajukan");
    getUser();
  }

  User? user;

  Future<void> getUser() async {
    final authServices = AuthServices();
    final auth = await authServices.me();
    if (auth != null) {
      setState(() {
        user = auth;
      });
    }
  }

  showSuccessDialog(BuildContext context, String id) {
    AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.WARNING,
      title: 'Warning!',
      titleTextStyle: MyFont.poppins(
          fontSize: 25, color: lavender, fontWeight: FontWeight.bold),
      desc: 'Apakah anda yakin, untuk membatalkan surat?',
      descTextStyle: MyFont.poppins(fontSize: 12, color: softgrey),
      btnOkOnPress: () {
        pembatalan(id);
        apiServices.sendNotification("Pengajuan surat anda berhasil dibatalkan",
            user?.fcmToken ?? "", "Berhasil");
      },
      btnCancelOnPress: () {
        Navigator.pop(context);
      },
      btnCancelIcon: Icons.highlight_off_rounded,
      btnOkIcon: Icons.task_alt_rounded,
    ).show();
  }

  Future pembatalan(String id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      var res = await http.post(Uri.parse("${Api.pembatalan}/$id"),
          headers: {"Authorization": "Bearer $token"});
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        if (data['message'] == "Surat berhasil dibatalkan") {
          Fluttertoast.showToast(
              msg: "Berhasil membatalkan surat",
              backgroundColor: Colors.green,
              toastLength: Toast.LENGTH_LONG);
          apiServices.sendNotification(
              "Pengajuan surat anda berhasil dibatalkan",
              user?.fcmToken ?? "",
              "Berhasil");
        } else {
          Fluttertoast.showToast(
              msg: "Gagal membatalkan surat",
              backgroundColor: Colors.red,
              toastLength: Toast.LENGTH_LONG);
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Pengajuan>>(
      future: listdata,
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          List<Pengajuan>? data = snapshot.data;
          return Expanded(
            child: RefreshIndicator(
              color: lavender,
              onRefresh: () async {
                listdata = apiServices.getStatus("Diajukan");
              },
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: data!.length,
                itemBuilder: (context, index) {
                  String dateTime = data[index].createdAt.toString();
                  final date = DateTime.parse(dateTime);
                  initializeDateFormatting('id_ID', null);
                  final dateFormat = DateFormat('dd MMMM yyyy', 'id_ID');
                  final timeFormat = DateFormat('HH:mm');
                  final formattedDate = dateFormat.format(date);
                  final formattedTime = timeFormat.format(date);
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailSurat(
                                surat: data[index].surat!,
                                pengajuan: data[index],
                                masyarakat: data[index].masyarakat!),
                          ));
                    },
                    child: Container(
                      height: 120,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "S-Kepuharjo",
                                      style: MyFont.poppins(
                                          fontSize: 10,
                                          color: black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "$formattedDate  $formattedTime",
                                      style: MyFont.poppins(
                                          fontSize: 10, color: softgrey),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 30,
                                  width: 90,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey.withOpacity(0.2)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        data[index].status.toString(),
                                        style: MyFont.poppins(
                                            fontSize: 10,
                                            color: black,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 8),
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: primaryColor.withOpacity(0.1)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.network(
                                            Api.connectimage +
                                                data[index]
                                                    .surat!
                                                    .image
                                                    .toString(),
                                            height: 40,
                                            width: 40,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: SizedBox(
                                        height: 40,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data[index]
                                                  .masyarakat!
                                                  .nik
                                                  .toString(),
                                              style: MyFont.poppins(
                                                  fontSize: 12,
                                                  color: black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              data[index]
                                                  .masyarakat!
                                                  .namaLengkap
                                                  .toString(),
                                              style: MyFont.poppins(
                                                fontSize: 12,
                                                color: black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => DetailSurat(
                                                  surat: data[index].surat!,
                                                  pengajuan: data[index],
                                                  masyarakat:
                                                      data[index].masyarakat!),
                                            ));
                                      },
                                      child: Icon(
                                        Icons.info_outline_rounded,
                                        color: black,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Expanded(
            child: ListView.builder(
              itemCount: 6,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  child: CardLoading(
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              },
            ),
          );
        }
        return Expanded(
          child: ListView.builder(
            itemCount: 6,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                height: 120,
                width: MediaQuery.of(context).size.width,
                child: CardLoading(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
