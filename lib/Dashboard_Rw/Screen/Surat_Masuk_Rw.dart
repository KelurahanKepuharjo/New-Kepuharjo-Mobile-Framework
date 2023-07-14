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

class SuratMasukRw extends StatefulWidget {
  const SuratMasukRw({super.key});

  @override
  State<SuratMasukRw> createState() => _SuratMasukRwState();
}

class _SuratMasukRwState extends State<SuratMasukRw> {
  List<Pengajuan> pengajuan = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getSuratMasuk();
  }

  Future<void> _getSuratMasuk() async {
    final api = ApiServices();
    final surat = await api.getPengajuanRw("Disetujui RT");
    setState(() {
      pengajuan = surat;
    });
  }

  ApiServices apiServices = ApiServices();

  Future status_setuju_rw(String id, String fcmToken) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      var res = await http.post(Uri.parse("${Api.status_setuju_rw}/$id"),
          headers: {"Authorization": "Bearer $token"});
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        if (data['message'] == "Status surat updated successfully") {
          Fluttertoast.showToast(
              msg: "Status pengajuan berhasil disetujui",
              backgroundColor: Colors.black.withOpacity(0.7));
          apiServices.sendNotification(
              "Pengajuan surat anda telah disetujui oleh pihak RW",
              fcmToken,
              "Pengajuan Surat Disetujui");
        }
      } else {
        Fluttertoast.showToast(
            msg: data['message'], backgroundColor: black.withOpacity(0.7));
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
                                                  scrollable: true,
                                                  content:
                                                      SingleChildScrollView(
                                                    child: Expanded(
                                                      child: Column(
                                                        children: [
                                                          GetTextFieldUser(
                                                            controller: TextEditingController(
                                                                text: pengajuan[
                                                                        index]
                                                                    .noPengantar),
                                                            label:
                                                                "No. Pengantar",
                                                            isEnable: true,
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                            inputFormatters:
                                                                FilteringTextInputFormatter
                                                                    .singleLineFormatter,
                                                            length: 255,
                                                            icon: Icons.receipt,
                                                          ),
                                                          GetTextFieldUser(
                                                            controller: TextEditingController(
                                                                text: pengajuan[
                                                                        index]
                                                                    .masyarakat!
                                                                    .nik
                                                                    .toString()),
                                                            label:
                                                                "Nomor Induk Keluarga",
                                                            isEnable: false,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters:
                                                                FilteringTextInputFormatter
                                                                    .digitsOnly,
                                                            length: 16,
                                                            icon: Icons.badge,
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
                                                            icon: Icons
                                                                .calendar_month,
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
                                                            icon: Icons
                                                                .man_3_outlined,
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
                                                            icon: Icons
                                                                .account_balance,
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
                                                            icon: Icons.school,
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
                                                            icon: Icons.work,
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
                                                            icon: Icons.opacity,
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
                                                            icon: Icons
                                                                .people_rounded,
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons.image,
                                                                size: 25,
                                                                color: grey,
                                                              ),
                                                              const SizedBox(
                                                                width: 8,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Foto Kartu Keluarga",
                                                                    style: MyFont.poppins(
                                                                        fontSize:
                                                                            11,
                                                                        color:
                                                                            black),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) {
                                                                          return AlertDialog(
                                                                            content:
                                                                                Image.network(
                                                                              Api.connectimage + pengajuan[index].imageKk.toString(),
                                                                            ),
                                                                          );
                                                                        },
                                                                      );
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .grey
                                                                            .withOpacity(0.2),
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                      ),
                                                                      child:
                                                                          Text(
                                                                        pengajuan[index]
                                                                            .imageKk
                                                                            .toString(),
                                                                        style: MyFont.poppins(
                                                                            fontSize:
                                                                                11,
                                                                            color:
                                                                                black),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons.image,
                                                                size: 25,
                                                                color: grey,
                                                              ),
                                                              const SizedBox(
                                                                width: 8,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Foto Bukti",
                                                                    style: MyFont.poppins(
                                                                        fontSize:
                                                                            11,
                                                                        color:
                                                                            black),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) {
                                                                          return AlertDialog(
                                                                            content:
                                                                                Image.network(
                                                                              Api.connectimage + pengajuan[index].imageBukti.toString(),
                                                                            ),
                                                                          );
                                                                        },
                                                                      );
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .grey
                                                                            .withOpacity(0.2),
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                      ),
                                                                      child:
                                                                          Text(
                                                                        pengajuan[index]
                                                                            .imageBukti
                                                                            .toString(),
                                                                        style: MyFont.poppins(
                                                                            fontSize:
                                                                                11,
                                                                            color:
                                                                                black),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Spacer(),
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
                                                                        status_setuju_rw(
                                                                            pengajuan[index].idPengajuan.toString(),
                                                                            pengajuan[index].masyarakat!.user!.fcmToken.toString());
                                                                        _getSuratMasuk();
                                                                        Navigator.pop(
                                                                            context);
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
