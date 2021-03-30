import 'package:atenciones_v2/constants/constants.dart';
import 'package:flutter/material.dart';

import 'package:atenciones_v2/helpers/default_appbar.dart';

class NewAppointment extends StatefulWidget {
  static const id = 'new_appointment';
  @override
  _NewAppointmentState createState() => _NewAppointmentState();
}

class _NewAppointmentState extends State<NewAppointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar('Nueva atención', true),
      backgroundColor: kLightGrey,
      body: Container(),
    );
  }
}
