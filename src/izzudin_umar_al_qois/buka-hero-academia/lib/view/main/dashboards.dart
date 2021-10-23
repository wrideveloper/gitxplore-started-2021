import 'package:buka_hero_academia/utils/palette.dart';
import 'package:flutter/material.dart';


class Dashboards extends StatefulWidget {
  @override
  _DashboardsState createState() => _DashboardsState();
}

class _DashboardsState extends State<Dashboards> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.primary,
        title: TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            filled: true,
            fillColor: Colors.white,
            border: InputBorder.none,
            hintText: 'Cari Produk Kesukaan Kamu',
          ),
        ),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {})
        ],
      ),
    );
  }
}