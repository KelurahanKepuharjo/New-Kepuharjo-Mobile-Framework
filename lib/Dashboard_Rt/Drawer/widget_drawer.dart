import 'package:flutter/material.dart';

class NavigationModel {
  String title;
  IconData icon;

  NavigationModel({required this.title, required this.icon});
}

List<NavigationModel> navigationItems = [
  NavigationModel(title: "Dashboard", icon: Icons.insert_chart),
  NavigationModel(title: "Surat Masuk", icon: Icons.pending_outlined),
  NavigationModel(title: "Surat Ditolak", icon: Icons.highlight_off_rounded),
  NavigationModel(title: "Surat Selesai", icon: Icons.task_alt_rounded),
  NavigationModel(title: "Rekap Surat", icon: Icons.assessment_outlined),
  NavigationModel(title: "Tentang", icon: Icons.info_outline_rounded),
];
