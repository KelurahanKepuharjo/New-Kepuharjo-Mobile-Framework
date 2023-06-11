import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_kepuharjo_new/Model/Pengajuan.dart';
import 'package:mobile_kepuharjo_new/Resource/MyTextField.dart';
import 'package:mobile_kepuharjo_new/Resource/Mycolor.dart';
import 'package:mobile_kepuharjo_new/Resource/Myfont.dart';
import 'package:mobile_kepuharjo_new/Services/api_connect.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_kepuharjo_new/Services/api_services.dart';

class SuratMasuk extends StatefulWidget {
  const SuratMasuk({super.key});

  @override
  State<SuratMasuk> createState() => _SuratMasukState();
}

class _SuratMasukState extends State<SuratMasuk> {
  List<Pengajuan> pengajuan = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getSuratMasuk();
  }

  Future<void> _getSuratMasuk() async {
    final api = ApiServices();
    final surat = await api.getPengajuanRt("Diajukan");
    setState(() {
      pengajuan = surat;
    });
  }

  Future updatestatussetujui(String nik, String idSurat) async {
    try {
      var res = await http.post(Uri.parse(Api.update_status_setujui_rt),
          body: {"nik": nik, "id_surat": idSurat});
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        if (data['message'] == "Status pengajuan berhasil diupdate") {
          Fluttertoast.showToast(
              msg: "Status pengajuan berhasil disetujui",
              backgroundColor: Colors.green);
        }
      } else if (res.statusCode == 404) {
        Fluttertoast.showToast(
            msg: data['message'], backgroundColor: Colors.red);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future updatestatustolak(String nik, String idSurat) async {
    try {
      var res = await http.post(Uri.parse(Api.update_status_tolak_rt),
          body: {"nik": nik, "id_surat": idSurat});
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        if (data['message'] == "Status pengajuan berhasil diupdate") {
          Fluttertoast.showToast(
              msg: "Status pengajuan berhasil ditolak",
              backgroundColor: Colors.red);
        }
      } else if (res.statusCode == 404) {
        Fluttertoast.showToast(
            msg: data['message'], backgroundColor: Colors.red);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _getSuratMasuk();
          });
        },
        child: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(10),
              child: Card(
                elevation: 3, // tinggi bayangan
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Surat Masuk",
                                  style: MyFont.poppins(
                                      fontSize: 14,
                                      color: black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Menampilkan data surat masuk untuk disetujui maupun ditolak",
                                  style: MyFont.poppins(
                                      fontSize: 12,
                                      color: softgrey,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                                columns: [
                                  DataColumn(
                                    label: Text(
                                      "No.",
                                      style: MyFont.poppins(
                                          fontSize: 12, color: black),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Nama",
                                      style: MyFont.poppins(
                                          fontSize: 12, color: black),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Jenis",
                                      style: MyFont.poppins(
                                          fontSize: 12, color: black),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Status",
                                      style: MyFont.poppins(
                                          fontSize: 12, color: black),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Proses",
                                      style: MyFont.poppins(
                                          fontSize: 12, color: black),
                                    ),
                                  ),
                                ],
                                rows: pengajuan.map((e) {
                                  return DataRow(cells: [
                                    DataCell(Text(
                                      ('${pengajuan.indexOf(e) + 1}')
                                          .toString(),
                                      style: MyFont.poppins(
                                          fontSize: 11, color: black),
                                    )),
                                    DataCell(Text(
                                      e.masyarakat!.namaLengkap.toString(),
                                      style: MyFont.poppins(
                                          fontSize: 11, color: black),
                                    )),
                                    DataCell(Text(
                                      e.surat!.namaSurat.toString(),
                                      style: MyFont.poppins(
                                          fontSize: 11, color: black),
                                    )),
                                    DataCell(Container(
                                      height: 25,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey.withOpacity(0.2)),
                                      child: Center(
                                        child: Text(
                                          e.status.toString(),
                                          textAlign: TextAlign.center,
                                          style: MyFont.poppins(
                                              fontSize: 11,
                                              color: black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )),
                                    DataCell(SizedBox(
                                      height: 35,
                                      width: 100,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: blue,
                                              shadowColor: Colors.transparent,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              )),
                                          onPressed: () {
                                            int index = pengajuan.indexOf(e);
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  content:
                                                      SingleChildScrollView(
                                                    child: Expanded(
                                                      child: Column(
                                                        children: [
                                                          GetTextFieldUser(
                                                            controller: TextEditingController(
                                                                text: pengajuan[
                                                                        index]
                                                                    .masyarakat!
                                                                    .nik
                                                                    .toString()),
                                                            label: "NIK",
                                                            isEnable: false,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters:
                                                                FilteringTextInputFormatter
                                                                    .digitsOnly,
                                                            length: 16,
                                                            icon: Icons
                                                                .credit_card,
                                                          ),
                                                          GetTextFieldUser(
                                                            controller: TextEditingController(
                                                                text: pengajuan[
                                                                        index]
                                                                    .masyarakat!
                                                                    .namaLengkap
                                                                    .toString()),
                                                            label:
                                                                "Nama Lengkap",
                                                            isEnable: false,
                                                            keyboardType:
                                                                TextInputType
                                                                    .name,
                                                            inputFormatters:
                                                                FilteringTextInputFormatter
                                                                    .digitsOnly,
                                                            length: 16,
                                                            icon: Icons.person,
                                                          ),
                                                          GetTextFieldUser(
                                                            controller:
                                                                TextEditingController(
                                                                    text:
                                                                        "${pengajuan[index].masyarakat!.tempatLahir}, ${pengajuan[index].masyarakat!.tglLahir}"),
                                                            label:
                                                                "Tempat, Tanggal Lahir",
                                                            isEnable: false,
                                                            keyboardType:
                                                                TextInputType
                                                                    .name,
                                                            inputFormatters:
                                                                FilteringTextInputFormatter
                                                                    .digitsOnly,
                                                            length: 16,
                                                            icon: Icons.person,
                                                          ),
                                                          GetTextFieldUser(
                                                            controller: TextEditingController(
                                                                text: pengajuan[
                                                                        index]
                                                                    .masyarakat!
                                                                    .jenisKelamin
                                                                    .toString()),
                                                            label:
                                                                "Jenis Kelamin",
                                                            isEnable: false,
                                                            keyboardType:
                                                                TextInputType
                                                                    .name,
                                                            inputFormatters:
                                                                FilteringTextInputFormatter
                                                                    .digitsOnly,
                                                            length: 16,
                                                            icon: Icons.person,
                                                          ),
                                                          GetTextFieldUser(
                                                            controller: TextEditingController(
                                                                text: pengajuan[
                                                                        index]
                                                                    .masyarakat!
                                                                    .agama
                                                                    .toString()),
                                                            label: "Agama",
                                                            isEnable: false,
                                                            keyboardType:
                                                                TextInputType
                                                                    .name,
                                                            inputFormatters:
                                                                FilteringTextInputFormatter
                                                                    .digitsOnly,
                                                            length: 16,
                                                            icon: Icons.person,
                                                          ),
                                                          GetTextFieldUser(
                                                            controller: TextEditingController(
                                                                text: pengajuan[
                                                                        index]
                                                                    .masyarakat!
                                                                    .pendidikan
                                                                    .toString()),
                                                            label: "Pendidikan",
                                                            isEnable: false,
                                                            keyboardType:
                                                                TextInputType
                                                                    .name,
                                                            inputFormatters:
                                                                FilteringTextInputFormatter
                                                                    .digitsOnly,
                                                            length: 16,
                                                            icon: Icons.person,
                                                          ),
                                                          GetTextFieldUser(
                                                            controller: TextEditingController(
                                                                text: pengajuan[
                                                                        index]
                                                                    .masyarakat!
                                                                    .pekerjaan
                                                                    .toString()),
                                                            label: "Pekerjaan",
                                                            isEnable: false,
                                                            keyboardType:
                                                                TextInputType
                                                                    .name,
                                                            inputFormatters:
                                                                FilteringTextInputFormatter
                                                                    .digitsOnly,
                                                            length: 16,
                                                            icon: Icons.person,
                                                          ),
                                                          GetTextFieldUser(
                                                            controller: TextEditingController(
                                                                text: pengajuan[
                                                                        index]
                                                                    .masyarakat!
                                                                    .golonganDarah
                                                                    .toString()),
                                                            label:
                                                                "Golongan Darah",
                                                            isEnable: false,
                                                            keyboardType:
                                                                TextInputType
                                                                    .name,
                                                            inputFormatters:
                                                                FilteringTextInputFormatter
                                                                    .digitsOnly,
                                                            length: 16,
                                                            icon: Icons.person,
                                                          ),
                                                          GetTextFieldUser(
                                                            controller: TextEditingController(
                                                                text: pengajuan[
                                                                        index]
                                                                    .masyarakat!
                                                                    .statusPerkawinan
                                                                    .toString()),
                                                            label:
                                                                "Status Perkawinan",
                                                            isEnable: false,
                                                            keyboardType:
                                                                TextInputType
                                                                    .name,
                                                            inputFormatters:
                                                                FilteringTextInputFormatter
                                                                    .digitsOnly,
                                                            length: 16,
                                                            icon: Icons.person,
                                                          ),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              SizedBox(
                                                                height: 40,
                                                                width: 80,
                                                                child: ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                        backgroundColor: Colors.green,
                                                                        shadowColor: Colors.transparent,
                                                                        shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                        )),
                                                                    onPressed: () {
                                                                      setState(
                                                                          () {
                                                                        updatestatussetujui(
                                                                            pengajuan[index].masyarakat!.nik.toString(),
                                                                            pengajuan[index].idSurat.toString());
                                                                      });
                                                                    },
                                                                    child: Text(
                                                                      "Setujui",
                                                                      style: MyFont.poppins(
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              white),
                                                                    )),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                width: 80,
                                                                child: ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                        backgroundColor: Colors.red,
                                                                        shadowColor: Colors.transparent,
                                                                        shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                        )),
                                                                    onPressed: () {
                                                                      setState(
                                                                          () {
                                                                        updatestatustolak(
                                                                            pengajuan[index].masyarakat!.nik.toString(),
                                                                            pengajuan[index].idSurat.toString());
                                                                      });
                                                                    },
                                                                    child: Text(
                                                                      "Tolak",
                                                                      style: MyFont.poppins(
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              white),
                                                                    )),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Text(
                                            'Preview Data',
                                            style: MyFont.poppins(
                                                fontSize: 11, color: white),
                                          )),
                                    ))
                                  ]);
                                }).toList()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
