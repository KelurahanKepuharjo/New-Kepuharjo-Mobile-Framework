import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/dashboard_user.dart';
import 'package:mobile_kepuharjo_new/Model/Masyarakat.dart';
import 'package:mobile_kepuharjo_new/Model/Pengajuan.dart';
import 'package:mobile_kepuharjo_new/Model/Surat.dart';
import 'package:mobile_kepuharjo_new/Resource/MyTextField_Pengajuan.dart';
import 'package:mobile_kepuharjo_new/Resource/Mycolor.dart';
import 'package:mobile_kepuharjo_new/Resource/Myfont.dart';
import 'package:intl/intl.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:mobile_kepuharjo_new/Services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_kepuharjo_new/Services/api_connect.dart';

class InfoSurat extends StatefulWidget {
  Masyarakat masyarakat;
  Surat surat;
  Pengajuan pengajuan;

  InfoSurat(
      {Key? key,
      required this.surat,
      required this.pengajuan,
      required this.masyarakat})
      : super(key: key);

  @override
  State<InfoSurat> createState() => _InfoSuratState();
}

class _InfoSuratState extends State<InfoSurat> {
  bool isKetTolakVisible = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.pengajuan.keteranganDitolak != null &&
        widget.pengajuan.keteranganDitolak!.isNotEmpty) {
      setState(() {
        isKetTolakVisible = true;
      });
    }
    nokk.text = widget.masyarakat.kks!.noKk.toString();
    nik.text = widget.masyarakat.nik.toString();
    nama.text = widget.masyarakat.namaLengkap.toString();
    ketTolak.text = widget.pengajuan.keteranganDitolak.toString();
    ttl.text =
        "${widget.masyarakat.tempatLahir}, ${DateFormat('dd MMMM yyyy').format(DateTime.parse(widget.masyarakat.tglLahir.toString()))}";
    goldarah.text = widget.masyarakat.golonganDarah.toString();
    jk.text = widget.masyarakat.jenisKelamin.toString();
    kewarganegaraan.text = widget.masyarakat.kewarganegaraan.toString();
    agama.text = widget.masyarakat.agama.toString();
    statusperkawinan.text = widget.masyarakat.statusPerkawinan.toString();
    pekerjaan.text = widget.masyarakat.pekerjaan.toString();
    pendidikan.text = widget.masyarakat.pendidikan.toString();
    alamat.text = widget.masyarakat.kks!.alamat.toString();
    rt.text = widget.masyarakat.kks!.rt.toString();
    rw.text = widget.masyarakat.kks!.rw.toString();
    keperluan.text = widget.pengajuan.keterangan.toString();
    imagekk.text = widget.pengajuan.imageKk.toString();
    imageBukti.text = widget.pengajuan.imageBukti.toString();
  }

  final nokk = TextEditingController();
  final nik = TextEditingController();
  final nama = TextEditingController();
  final ketTolak = TextEditingController();
  final ttl = TextEditingController();
  final goldarah = TextEditingController();
  final jk = TextEditingController();
  final kewarganegaraan = TextEditingController();
  final agama = TextEditingController();
  final statusperkawinan = TextEditingController();
  final pekerjaan = TextEditingController();
  final pendidikan = TextEditingController();
  final alamat = TextEditingController();
  final rt = TextEditingController();
  final rw = TextEditingController();
  final keperluan = TextEditingController();
  final imagekk = TextEditingController();
  final imageBukti = TextEditingController();
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
            "Info Surat",
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
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 20),
              child: Text(
                "Pengajuan Surat Keterangan ${widget.surat.namaSurat}",
                style: MyFont.poppins(
                    fontSize: 13, color: black, fontWeight: FontWeight.bold),
              ),
            ),
            GetTextFieldPengajuan(
                controller: nokk,
                label: "No. Kartu Keluarga",
                keyboardType: TextInputType.name,
                inputFormatters:
                    FilteringTextInputFormatter.singleLineFormatter),
            GetTextFieldPengajuan(
              controller: nik,
              label: "No. Induk Keluarga",
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            GetTextFieldPengajuan(
              controller: nama,
              label: "Nama Lengkap",
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            GetTextFieldPengajuan(
              controller: ttl,
              label: "Tempat, Tanggal Lahir",
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            GetTextFieldPengajuan(
              controller: goldarah,
              label: "Golongan Darah",
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            GetTextFieldPengajuan(
              controller: jk,
              label: "Jenis Kelamin",
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            GetTextFieldPengajuan(
              controller: kewarganegaraan,
              label: "Kewarganegaraan",
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            GetTextFieldPengajuan(
              controller: agama,
              label: "Agama",
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            GetTextFieldPengajuan(
              controller: statusperkawinan,
              label: "Status Perkawinan",
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            GetTextFieldPengajuan(
              controller: pekerjaan,
              label: "Pekerjaan",
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            GetTextFieldPengajuan(
              controller: pendidikan,
              label: "Pendidikan",
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            GetTextFieldPengajuan(
              controller: alamat,
              label: "Alamat",
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            GetTextFieldPengajuan(
              controller: rt,
              label: "RT",
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            GetTextFieldPengajuan(
              controller: rw,
              label: "RW",
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            GetTextFieldPengajuan(
              controller: keperluan,
              label: "Keperluan",
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            Visibility(
              visible: isKetTolakVisible,
              child: GetTextFieldPengajuan(
                controller: ketTolak,
                label: "Keterangan Ditolak",
                keyboardType: TextInputType.name,
                inputFormatters:
                    FilteringTextInputFormatter.singleLineFormatter,
              ),
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Image.network(
                        Api.connectimage + widget.pengajuan.imageKk!.trim(),
                      ),
                    );
                  },
                );
              },
              child: GetTextFieldPengajuan(
                controller: imagekk,
                label: "Foto Kartu Keluarga",
                keyboardType: TextInputType.name,
                inputFormatters:
                    FilteringTextInputFormatter.singleLineFormatter,
              ),
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Image.network(
                        Api.connectimage + widget.pengajuan.imageBukti!.trim(),
                      ),
                    );
                  },
                );
              },
              child: GetTextFieldPengajuan(
                controller: imageBukti,
                label: "Foto Bukti",
                keyboardType: TextInputType.name,
                inputFormatters:
                    FilteringTextInputFormatter.singleLineFormatter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
