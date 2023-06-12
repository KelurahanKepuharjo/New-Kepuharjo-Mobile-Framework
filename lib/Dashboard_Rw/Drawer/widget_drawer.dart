import 'package:flutter/material.dart';

class NavigationModelRw {
  String title;
  IconData icon;

  NavigationModelRw({required this.title, required this.icon});
}

List<NavigationModelRw> navigationItems = [
  NavigationModelRw(title: "Dashboard", icon: Icons.insert_chart),
  NavigationModelRw(title: "Surat Masuk", icon: Icons.pending_outlined),
  NavigationModelRw(title: "Surat Selesai", icon: Icons.task_alt_rounded),
  NavigationModelRw(title: "Rekap Surat", icon: Icons.assessment_outlined),
  NavigationModelRw(title: "Tentang", icon: Icons.info_outline_rounded),
];
