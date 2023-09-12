import 'package:flutter/material.dart';
import 'package:mobile_kepuharjo_new/Model/Pengajuan.dart';
import 'package:mobile_kepuharjo_new/Model/Surat.dart';
import 'package:mobile_kepuharjo_new/Resource/Mycolor.dart';
import 'package:mobile_kepuharjo_new/Resource/Myfont.dart';
import 'package:mobile_kepuharjo_new/Services/api_connect.dart';
import 'package:mobile_kepuharjo_new/Services/api_services.dart';

class WidgetCardRw extends StatefulWidget {
  const WidgetCardRw({super.key});

  @override
  State<WidgetCardRw> createState() => _WidgetCardRwState();
}

class _WidgetCardRwState extends State<WidgetCardRw> {
  List<Surat> _surat = [];
  List<Pengajuan> pengajuan = [];
  List<Pengajuan> pengajuan1 = [];
  List<Pengajuan> pengajuan2 = [];
  @override
  void initState() {
    super.initState();
    _getSurat();
    _getSuratMasuk();
    _getSuratDisetujui();
  }

  Future<void> _getSurat() async {
    final api = ApiServices();
    final surat = await api.getSurat();
    setState(() {
      _surat = surat;
    });
  }

  Future<void> _getSuratMasuk() async {
    final api = ApiServices();
    final surat = await api.getPengajuanRw("Disetujui RT");
    setState(() {
      pengajuan = surat;
    });
  }

  Future<void> _getSuratDisetujui() async {
    final api = ApiServices();
    final surat = await api.getPengajuanRw("Disetujui RW");
    setState(() {
      pengajuan1 = surat;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Column(
        children: [
          // SizedBox(
          //   height: 125,
          //   width: MediaQuery.of(context).size.width,
          //   child: ListView.builder(
          //     itemCount: 3,
          //     shrinkWrap: true,
          //     scrollDirection: Axis.horizontal,
          //     itemBuilder: (context, index) {
          //       return Stack(
          //         fit: StackFit.loose,
          //         children: [
          //           Container(
          //             margin: const EdgeInsets.symmetric(horizontal: 8),
          //             // padding: const EdgeInsets.all(10),
          //             height: 125,
          //             width: 200,
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(10),
          //               color: (index == 0)
          //                   ? Colors.yellow
          //                   : (index == 1)
          //                       ? Colors.green
          //                       : (index == 2)
          //                           ? Colors.red
          //                           : Colors.grey,
          //             ),
          //           ),
          //           Container(
          //             padding: const EdgeInsets.all(10),
          //             margin: const EdgeInsets.symmetric(horizontal: 8),
          //             height: 125,
          //             width: 193,
          //             decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(10),
          //                 color: white),
          //             child: Column(
          //               children: [
          //                 Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: [
          //                     (index == 0)
          //                         ? Text(
          //                             "Surat\nMasuk",
          //                             style: MyFont.poppins(
          //                                 fontSize: 16,
          //                                 color: black,
          //                                 fontWeight: FontWeight.bold),
          //                           )
          //                         : (index == 1)
          //                             ? Text(
          //                                 "Surat\nDisetujui",
          //                                 style: MyFont.poppins(
          //                                     fontSize: 16,
          //                                     color: black,
          //                                     fontWeight: FontWeight.bold),
          //                               )
          //                             : (index == 2)
          //                                 ? Text(
          //                                     "Surat\nDitolak",
          //                                     style: MyFont.poppins(
          //                                         fontSize: 16,
          //                                         color: black,
          //                                         fontWeight: FontWeight.bold),
          //                                   )
          //                                 : SizedBox(),
          //                     (index == 0)
          //                         ? Image.asset(
          //                             "images/masuk.png",
          //                             height: 50,
          //                           )
          //                         : (index == 1)
          //                             ? Image.asset(
          //                                 "images/proses.png",
          //                                 height: 40,
          //                               )
          //                             : (index == 2)
          //                                 ? Image.asset(
          //                                     "images/tolak.png",
          //                                     height: 40,
          //                                   )
          //                                 : SizedBox(),
          //                   ],
          //                 )
          //               ],
          //             ),
          //           ),
          //         ],
          //       );
          //     },
          //   ),
          // ),
          Container(
            margin: EdgeInsets.only(top: 0),
            width: MediaQuery.of(context).size.width,
            height: 211,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.blue.shade900,
                  Colors.blue.shade800,
                  Colors.blue.shade600,
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 0),
                    padding: EdgeInsets.all(15),
                    height: 195,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10)),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Jenis Pengajuan Surat",
                            style: MyFont.poppins(
                                fontSize: 14,
                                color: black,
                                fontWeight: FontWeight.normal),
                          ),
                          DataTable(
                              columns: [
                                DataColumn(
                                    label: Text(
                                  style: MyFont.poppins(
                                      fontSize: 12, color: black),
                                  "Gambar",
                                )),
                                DataColumn(
                                    label: Text(
                                  "Nama Surat",
                                  style: MyFont.poppins(
                                      fontSize: 12, color: black),
                                ))
                              ],
                              rows: _surat.map((e) {
                                return DataRow(cells: [
                                  DataCell(Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Image.network(
                                      Api.connectimage + e.image!.trim(),
                                      height: 50,
                                      width: 50,
                                    ),
                                  )),
                                  DataCell(Text(
                                    "Surat Keterangan ${e.namaSurat}",
                                    style: MyFont.poppins(
                                        fontSize: 11, color: black),
                                  )),
                                ]);
                              }).toList())
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
