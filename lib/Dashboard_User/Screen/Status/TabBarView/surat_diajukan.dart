import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_kepuharjo_new/Model/Pengajuan.dart';
import 'package:mobile_kepuharjo_new/Resource/Mycolor.dart';
import 'package:mobile_kepuharjo_new/Resource/Myfont.dart';
import 'package:mobile_kepuharjo_new/Services/api_connect.dart';
import 'package:mobile_kepuharjo_new/Services/api_services.dart';
import 'package:http/http.dart' as http;

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
  }

  List<bool> _isVisible = [];
  showSuccessDialog(BuildContext context, String nik, String idSurat) {
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
        pembatalan(nik, idSurat);
        setState(() {
          _isVisible.add(false);
        });
      },
      btnCancelOnPress: () {
        Navigator.pop(context);
      },
      btnCancelIcon: Icons.highlight_off_rounded,
      btnOkIcon: Icons.task_alt_rounded,
    ).show();
  }

  Future pembatalan(String nik, String idSurat) async {
    try {
      var res = await http.post(Uri.parse(Api.pembatalan), body: {
        "nik": nik,
        "id_surat": idSurat,
      });
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        if (data['message'] == "Surat berhasil dibatalkan") {
          setState(() {
            listdata = apiServices.getStatus("Diajukan");
          });
          Fluttertoast.showToast(
              msg: "Berhasil membatalkan surat",
              backgroundColor: Colors.green,
              toastLength: Toast.LENGTH_LONG);
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
          if (_isVisible.length == 0) {
            for (int i = 0; i < data!.length; i++) {
              _isVisible.add(false);
            }
          }
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
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _isVisible[index] = !_isVisible[index];
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.fastOutSlowIn,
                      height: _isVisible[index] ? 172 : 115,
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
                                      data[index].createdAt.toString(),
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
                                      color: Colors.grey),
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
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: blue.withOpacity(0.1)),
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
                                            height: 25,
                                            width: 25,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          _isVisible[index] =
                                              !_isVisible[index];
                                        });
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
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
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _isVisible[index] =
                                              !_isVisible[index];
                                        });
                                      },
                                      child: Icon(
                                        _isVisible[index]
                                            ? Icons.keyboard_arrow_down_rounded
                                            : Icons
                                                .keyboard_arrow_right_rounded,
                                        color: lavender,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AnimatedSize(
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.fastOutSlowIn,
                            vsync: this,
                            child: Visibility(
                              visible: _isVisible[index],
                              child: Container(
                                margin: EdgeInsets.all(8),
                                height: _isVisible[index] ? 40 : 0,
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: lavender,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        )),
                                    onPressed: () {
                                      showSuccessDialog(
                                          context,
                                          data[index]
                                              .masyarakat!
                                              .nik
                                              .toString(),
                                          data[index].idSurat.toString());
                                    },
                                    child: Text('Batalkan Surat',
                                        style: MyFont.poppins(
                                            fontSize: 12, color: white))),
                              ),
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
          return Text("${snapshot.error}");
        }
        return Center(
          child: CircularProgressIndicator(
            color: blue,
          ),
        );
      },
    );
  }
}
