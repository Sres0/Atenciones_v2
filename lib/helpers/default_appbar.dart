import 'package:flutter/material.dart';

AppBar defaultAppBar(String title, bool backButton) {
  return AppBar(
    automaticallyImplyLeading: backButton,
    centerTitle: true,
    title: Text(title),
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}
