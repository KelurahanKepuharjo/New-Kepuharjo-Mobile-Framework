import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_kepuharjo_new/Resource/Myfont.dart';
import 'package:mobile_kepuharjo_new/Resource/Mycolor.dart';

class SnackbarType {
  static const String success = "Berhasil";
  static const String failed = "Gagal";
  static const String error = "Error";
}

class MySnackbar {
  final String type;
  final String title;

  MySnackbar({required this.type, required this.title});

  void showSnackbar(BuildContext context) {
    Flushbar(
      duration: const Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.BOTTOM,
      icon: _getIcon(),
      shouldIconPulse: false,
      // title: type,
      messageText: Text(title,
          style: MyFont.poppins(
              fontSize: 12, color: white, fontWeight: FontWeight.w500)),
      titleText: Text(
        type,
        style: GoogleFonts.inter(
            fontSize: 16, color: white, fontWeight: FontWeight.bold),
      ),
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
      borderRadius: BorderRadius.circular(16),
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 25),
      backgroundColor: _getColor(),
      barBlur: 10,
    ).show(context);
  }

  Color _getColor() {
    switch (type) {
      case SnackbarType.success:
        return Colors.green;
        break;
      case SnackbarType.failed:
        return Colors.red;
        break;
      case SnackbarType.error:
        return Colors.black.withOpacity(0.7);
        break;
      default:
        return Colors.grey;
        break;
    }
  }

  Icon _getIcon() {
    switch (type) {
      case SnackbarType.success:
        return Icon(
          Icons.task_alt_rounded,
          size: 30,
          color: white,
        );
        break;
      case SnackbarType.failed:
        return Icon(
          Icons.highlight_off_rounded,
          size: 30,
          color: white,
        );
        break;
      case SnackbarType.error:
        return Icon(
          Icons.error_outline,
          size: 30,
          color: white,
        );
        break;
      default:
        return Icon(
          Icons.warning,
          size: 30,
          color: white,
        );
        break;
    }
  }
}
