import 'package:flutter/material.dart';

const kPurple = Color(0xFF534bae);
const kLightBlue = Color(0xFFbbdefb);
const kDarkBlue = Color(0xFF000051);
const kGrey = Color(0xFF7C7C7C);
const kLightGrey = Color(0xFFC9C9C9);
const kErrorAlert = Color(0xFFD32F30);
const kBackgroundColor = Colors.white;

const kActiveCardColor = Color(0xFFE2E2E2);
const kInactiveCardColor = Colors.white;

const kActiveBorderColor = kDarkBlue;
const kInactiveBorderColor = kGrey;
const kActiveBtnColor = Color(0xFF9ED6FF);

const kTextFormFieldStyle = TextStyle(fontSize: 18.0);
const kTextFieldDecoration = InputDecoration(
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

const kDropdownButtonFormFieldDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kLightGrey, width: 0.7),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kDarkBlue, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
);

const kErrorTitleTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w500,
  fontSize: 19.0,
);

const kLabelTextStyle = TextStyle(
  fontSize: 17.0,
  color: Color(0xFF8D8E98),
);
