import 'package:flutter/material.dart';

import 'package:atenciones_v2/models/appointment.dart';

class IndividualAppointment extends StatefulWidget {
  static const id = 'appointment_main';
  final Appointment appointment;

  IndividualAppointment({this.appointment});

  @override
  _IndividualAppointmentState createState() => _IndividualAppointmentState();
}

class _IndividualAppointmentState extends State<IndividualAppointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Hi. This is ${appointmentName(widget.appointment.type)}'),
      ),
    );
  }
}
