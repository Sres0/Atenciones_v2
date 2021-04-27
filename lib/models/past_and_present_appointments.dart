// import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:atenciones_v2/models/appointment.dart';

List<Appointment> presentAppointments = [
  Appointment(
    id: 0,
    type: 'medicina_especializada',
    place: 'HPTU',
    additionalInformation: ':)',
    date: DateTime.now().add(Duration(hours: 5)),
    time: TimeOfDay.now(),
  ),
  Appointment(
    id: 1,
    type: 'nutricion',
    place: 'HGM',
    additionalInformation: ':)',
    date: DateTime.now().add(Duration(days: 1)),
    time: TimeOfDay.now(),
  ),
];

List<Appointment> pastAppointments = [
  Appointment(
    id: 2,
    type: 'optometria',
    place: 'HGM',
    additionalInformation: ':)',
    date: DateTime.now().subtract(Duration(days: 12)),
    time: TimeOfDay.now(),
  ),
  Appointment(
    id: 3,
    type: 'odontologia_especializada',
    place: 'SVF',
    additionalInformation: ':)',
    date: DateTime.now().subtract(Duration(days: 4)),
    time: TimeOfDay.now(),
  ),
  Appointment(
    id: 4,
    type: 'psicologia',
    place: 'CES Sabaneta',
    additionalInformation: ':)',
    date: DateTime.now().subtract(Duration(days: 30)),
    time: TimeOfDay.now(),
  ),
];

int appointmentId = 5;
