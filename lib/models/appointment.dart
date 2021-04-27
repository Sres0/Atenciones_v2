import 'package:flutter/material.dart';

import 'package:atenciones_v2/constants/appointment_bank.dart';

class Appointment {
  final int id;
  final String place;
  final String type;
  final String additionalInformation;
  final DateTime date;
  final TimeOfDay time;

  Appointment({
    @required this.id,
    @required this.place,
    @required this.type,
    @required this.additionalInformation,
    @required this.date,
    @required this.time,
  });
}

appointmentName(String type) {
  for (var t in AppointmentBank().appointmentTypes) {
    if (t.type == type) {
      return t.name;
    }
  }
}

appointmentNameToType(String name) {
  for (var t in AppointmentBank().appointmentTypes) {
    if (t.name == name) {
      return t.type;
    }
  }
}
