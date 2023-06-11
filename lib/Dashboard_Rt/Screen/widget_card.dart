import 'package:flutter/material.dart';
import 'package:mobile_kepuharjo_new/Model/Pengajuan.dart';
import 'package:mobile_kepuharjo_new/Model/Surat.dart';
import 'package:mobile_kepuharjo_new/Resource/Mycolor.dart';
import 'package:mobile_kepuharjo_new/Resource/Myfont.dart';
import 'package:mobile_kepuharjo_new/Services/api_services.dart';

class WidgetCard extends StatefulWidget {
  const WidgetCard({super.key});

  @override
  State<WidgetCard> createState() => _WidgetCardState();
}

class _WidgetCardState extends State<WidgetCard> {
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
    _getSuratDitolak();
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
    final surat = await api.getPengajuanRt("Diajukan");
    setState(() {
      pengajuan = surat;
    });
  }

  Future<void> _getSuratDisetujui() async {
    final api = ApiServices();
    final surat = await api.getPengajuanRt("Disetujui RT");
    setState(() {
      pengajuan1 = surat;
    });
  }

  Future<void> _getSuratDitolak() async {
    final api = ApiServices();
    final surat = await api.getPengajuanRt("Ditolak RT");
    setState(() {
      pengajuan2 = surat;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          SizedBox(
            height: 100,
            child: Card(
              elevation: 1, // tinggi bayangan
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "${pengajuan.length}",
                            style: MyFont.poppins(
                                fontSize: 20,
                                color: black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Surat Masuk",
                            style: MyFont.poppins(
                                fontSize: 12,
                                color: black,
                                fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: 1,
                      height: MediaQuery.of(context).size.height,
                      color: black.withOpacity(0.2),
                    ),
                    SizedBox(
                      height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "${pengajuan1.length}",
                            style: MyFont.poppins(
                                fontSize: 20,
                                color: black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Surat Disetujui",
                            style: MyFont.poppins(
                                fontSize: 12,
                                color: black,
                                fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: 1,
                      height: MediaQuery.of(context).size.height,
                      color: black.withOpacity(0.2),
                    ),
                    SizedBox(
                      height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "${pengajuan2.length}",
                            style: MyFont.poppins(
                                fontSize: 20,
                                color: black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Surat Ditolak",
                            style: MyFont.poppins(
                                fontSize: 12,
                                color: black,
                                fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
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
                      child: Expanded(
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
                                    "No.",
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
                                    DataCell(Text(
                                      e.idSurat.toString(),
                                      style: MyFont.poppins(
                                          fontSize: 11, color: black),
                                    )),
                                    DataCell(Text(
                                      "Surat Keterangan " +
                                          e.namaSurat.toString(),
                                      style: MyFont.poppins(
                                          fontSize: 11, color: black),
                                    )),
                                  ]);
                                }).toList())
                          ],
                        ),
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
