import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:atenciones_v2/constants/constants.dart';
import 'package:atenciones_v2/validators/validation.dart';

class AppointmentDateAndTime extends StatefulWidget {
  AppointmentDateAndTime({
    @required this.hintTxt,
    @required this.textController,
    @required this.pickerFocusNode,
    @required this.isEnabled,
    @required this.disableAppointmentDateAndTime,
  });

  final String hintTxt;
  final TextEditingController textController;
  final FocusNode pickerFocusNode;
  final bool isEnabled;
  final Function disableAppointmentDateAndTime;

  @override
  _AppointmentDateAndTimeState createState() => _AppointmentDateAndTimeState();
}

class _AppointmentDateAndTimeState extends State<AppointmentDateAndTime> {
  TextEditingController textController;
  String hintTxt;
  DateTime appointmentDate;
  FocusNode pickerFocusNode;
  bool isEnabled;
  Function disableAppointmentDateAndTime;

  var dateFormatter = new DateFormat('yMd');
  String selectedDate;

  @override
  void initState() {
    hintTxt = widget.hintTxt;
    textController = widget.textController;
    disableAppointmentDateAndTime = widget.disableAppointmentDateAndTime;
    super.initState();
  }

  Future<Null> androidAppointmentDateAndTime(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        appointmentDate = pickedDate;
        selectedDate = dateFormatter.format(appointmentDate);
        textController.value = TextEditingValue(
          text: selectedDate.toString(),
        );
      });
    }
  }

  CupertinoDatePicker iosAppointmentDateAndTime() {
    return CupertinoDatePicker(
      mode: CupertinoDatePickerMode.date,
      initialDateTime: DateTime.now(),
      onDateTimeChanged: (DateTime newDateTime) {
        setState(() {
          appointmentDate = newDateTime;
          selectedDate = dateFormatter.format(appointmentDate);
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
        disableAppointmentDateAndTime();
        Platform.isIOS
            ? showModalBottomSheet(
                context: context,
                builder: (BuildContext builder) {
                  return Container(
                    child: iosAppointmentDateAndTime(),
                    height: MediaQuery.of(context).copyWith().size.height / 3,
                  );
                })
            : androidAppointmentDateAndTime(context);
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
