import 'package:buka_hero_academia/utils/palette.dart';
import 'package:flutter/material.dart';


class AppBarModule extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final Widget leading;
  final List<Widget> action;

  AppBarModule({ Key key, @required this.title, this.centerTitle, this.leading, this.action }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(61);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Palette.primary,
      title: Text(title, style: TextStyle(color: Colors.white, fontSize: 18.0)),
      leading: leading != null ? leading : IconButton(
        onPressed: () => Navigator.pop(context),
        alignment: Alignment.centerLeft,
        icon: Icon(Icons.arrow_back_ios, size: 22.0,)
      ),
      centerTitle: centerTitle,
      actions: action,
    );
  }
}