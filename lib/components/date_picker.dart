import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:atenciones_v2/constants/constants.dart';
import 'package:atenciones_v2/validators/validation.dart';

class DatePicker extends StatefulWidget {
  DatePicker({
    @required this.hintTxt,
    @required this.textController,
    @required this.pickerFocusNode,
    @required this.isEnabled,
    @required this.disableDatePicker,
  });

  final String hintTxt;
  final TextEditingController textController;
  final FocusNode pickerFocusNode;
  final bool isEnabled;
  final Function disableDatePicker;

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  TextEditingController textController;
  String hintTxt;
  DateTime birthDate;
  FocusNode pickerFocusNode;
  bool isEnabled;
  Function disableDatePicker;

  var formatter = new DateFormat('yyyy-MM-dd');
  String selectedDate;

  @override
  void initState() {
    hintTxt = widget.hintTxt;
    textController = widget.textController;
    disableDatePicker = widget.disableDatePicker;
    super.initState();
  }

  Future<Null> androidDatePicker(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        birthDate = pickedDate;
        selectedDate = formatter.format(birthDate);
        textController.value = TextEditingValue(
          text: selectedDate.toString(),
        );
      });
    }
  }

  CupertinoDatePicker iosDatePicker() {
    return CupertinoDatePicker(
      mode: CupertinoDatePickerMode.date,
      initialDateTime: DateTime.now(),
      onDateTimeChanged: (DateTime newDateTime) {
        setState(() {
          birthDate = newDateTime;
          selectedDate = formatter.format(birthDate);
          textController.value = TextEditingValue(
            text: selectedDate.toString(),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    pickerFocusNode = widget.pickerFocusNode;
    isEnabled = widget.isEnabled;

    return TextFormField(
      onTap: () {
        pickerFocusNode.unfocus();
        disableDatePicker();
        Platform.isIOS
            ? showModalBottomSheet(
                context: context,
                builder: (BuildContext builder) {
                  return Container(
                    child: iosDatePicker(),
                    height: MediaQuery.of(context).copyWith().size.height / 3,
                  );
                })
            : androidDatePicker(context);
      },
      readOnly: true,
      enabled: isEnabled,
      focusNode: pickerFocusNode,
      style: kTextFormFieldStyle,
      controller: textController,
      textAlign: TextAlign.center,
      decoration: kTextFieldDecoration.copyWith(
        hintText: hintTxt,
        hintStyle: kTextFormFieldStyle,
      ),
      validator: (value) {
        return Validator().validateDatePicker(value);
      },
    );
  }
}
