// import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:atenciones_v2/models/appointment.dart';

List<Appointment> presentAppointments = [
  Appointment(
    id: 0,
    type: 'enfermeria',
    place: 'CES Sabaneta',
    additionalInformation: ':)',
    date: DateTime.now().add(Duration(hours: 2)),
    time: TimeOfDay.now(),
  ),
  Appointment(
    id: 1,
    type: 'odontologia_general',
    place: 'HGM',
    additionalInformation: ':)',
    date: DateTime.now().add(Duration(days: 11)),
    time: TimeOfDay.now(),
  ),
  Appointment(
    id: 2,
    type: 'medicina_general',
    place: 'HPTU',
    additionalInformation: ':)',
    date: DateTime.now().add(Duration(days: 2)),
    time: TimeOfDay.now(),
  ),
  Appointment(
    id: 3,
    type: 'odontologia_general',
    place: 'HGM',
    additionalInformation: ':)',
    date: DateTime.now().add(Duration(days: 11)),
    time: TimeOfDay.now(),
  ),
  Appointment(
    id: 4,
    type: 'enfermería',
    place: 'SVF',
    additionalInformation: ':)',
    date: DateTime.now().add(Duration(days: 30)),
    time: TimeOfDay.now(),
  ),
];

List<Appointment> pastAppointments = [
  Appointment(
    id: 5,
    type: 'medicina_general',
    place: 'HGM',
    additionalInformation: ':)',
    date: DateTime.now().subtract(Duration(days: 12)),
    time: TimeOfDay.now(),
  ),
  Appointment(
    id: 6,
    type: 'odontologia_general',
    place: 'SVF',
    additionalInformation: ':)',
    date: DateTime.now().subtract(Duration(days: 4)),
    time: TimeOfDay.now(),
  ),
];

int appointmentId = 7;
