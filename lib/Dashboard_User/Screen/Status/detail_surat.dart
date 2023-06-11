import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_kepuharjo_new/Model/Masyarakat.dart';
import 'package:mobile_kepuharjo_new/Model/Pengajuan.dart';
import 'package:mobile_kepuharjo_new/Model/Surat.dart';
import 'package:mobile_kepuharjo_new/Resource/MyTextField_Pengajuan.dart';
import 'package:mobile_kepuharjo_new/Resource/Mycolor.dart';
import 'package:mobile_kepuharjo_new/Resource/Myfont.dart';
import 'package:intl/intl.dart';
import 'package:mobile_kepuharjo_new/Services/api_connect.dart';

class DetailSurat extends StatefulWidget {
  Masyarakat masyarakat;
  Surat surat;
  Pengajuan pengajuan;

  DetailSurat(
      {Key? key,
      required this.surat,
      required this.pengajuan,
      required this.masyarakat})
      : super(key: key);

  @override
  State<DetailSurat> createState() => _DetailSuratState();
}

class _DetailSuratState extends State<DetailSurat> {
  void initState() {
    // TODO: implement initState
    super.initState();
    nokk.text = widget.masyarakat.kks!.noKk.toString();
    nik.text = widget.masyarakat.nik.toString();
    nama.text = widget.masyarakat.namaLengkap.toString();
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
  }

  final nokk = TextEditingController();
  final nik = TextEditingController();
  final nama = TextEditingController();
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
          backgroundColor: lavender,
          shadowColor: Colors.transparent,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            "Info Surat",
            style: MyFont.poppins(
                fontSize: 16, color: white, fontWeight: FontWeight.bold),
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
        padding: const EdgeInsets.all(15),
        child: Column(
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
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "  Gambar foto Kartu Keluarga",
                        style: MyFont.poppins(fontSize: 12, color: black),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(Api.connectimage +
                                widget.pengajuan.imageKk!.trim()),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "  Gambar foto Kartu Keluarga",
                        style: MyFont.poppins(fontSize: 12, color: black),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(Api.connectimage +
                                widget.pengajuan.imageBukti!.trim()),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
