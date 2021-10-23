import 'package:buka_hero_academia/utils/palette.dart';
import 'package:buka_hero_academia/view/auth/loginCustomer.dart';
import 'package:buka_hero_academia/view/auth/registerCustomer.dart';
import 'package:flutter/material.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin{
  TabController _controller;

  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  _goBack() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.primary,
        title: Text('Masuk Aplikasi'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => _goBack(),
        ),
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Colors.white,
          tabs: <Widget> [
            Tab(child: Text('Masuk')),
            Tab(child: Text('Daftar'),)
          ]
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: <Widget> [
          LoginCustomer(),
          RegisterCustomer()
        ]
      )
    );
  }
}