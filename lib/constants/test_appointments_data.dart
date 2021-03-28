import 'package:atenciones_v2/models/appointment_model.dart';
import 'package:flutter/material.dart';

List<Appointment> presentAppointments = [
  Appointment(
    id: 0,
    type: 'Medicina general',
    place: 'HGM',
    additionalInformation: ':)',
    date: DateTime.now().add(Duration(hours: 2)),
    time: TimeOfDay.now(),
  ),
  Appointment(
    id: 2,
    type: 'Odontología',
    place: 'HGM',
    additionalInformation: ':)',
    date: DateTime.now().add(Duration(days: 11)),
    time: TimeOfDay.now(),
  ),
];

List<Appointment> pastAppointments = [
  Appointment(
    id: 1,
    type: 'Medicina general',
    place: 'CES Sabaneta',
    additionalInformation: ':)',
    date: DateTime.now().subtract(Duration(days: 12)),
    time: TimeOfDay.now(),
  ),
  Appointment(
    id: 3,
    type: 'Odontología',
    place: 'CES Sabaneta',
    additionalInformation: ':)',
    date: DateTime.now().subtract(Duration(days: 4)),
    time: TimeOfDay.now(),
  ),
];
