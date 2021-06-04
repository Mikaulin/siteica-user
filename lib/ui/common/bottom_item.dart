import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:siteica_user/ui/evolution.dart';
import 'package:siteica_user/ui/home.dart';
import 'package:siteica_user/ui/map.dart';

class BottomItem {
  final Widget page;
  final String title;
  final Icon icon;

  BottomItem({
    @required this.page,
    @required this.title,
    @required this.icon,
  });

  static List<BottomItem> get items => [
    BottomItem(
      page: HomePage(),
      icon: Icon(Icons.home),
      title: "Inicio",
    ),
    BottomItem(
      page: MapPage(),
      icon: Icon(Icons.location_on_outlined),
      title: "Mapa",
    ),
    BottomItem(
      page: EvolutionPage(),
      icon: Icon(Icons.show_chart),
      title: "Evolución",
    ),
  ];
}