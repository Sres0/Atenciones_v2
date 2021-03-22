import 'package:flutter/material.dart';

const kPurple = Color(0xFF534bae);
const kLightBlue = Color(0xFFbbdefb);
const kDarkBlue = Color(0xFF000051);
const kGrey = Color(0xFF7C7C7C);

const kTextFormFieldStyle = TextStyle(fontSize: 18.0);
const kTextFieldDecorationForLoginAndRegistration = InputDecoration(
  hintText: 'Ingresa un valor',
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kDarkBlue, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kDarkBlue, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
);
