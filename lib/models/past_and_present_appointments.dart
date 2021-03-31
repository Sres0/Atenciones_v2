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
  Appointment(
    id: 2,
    type: 'enfermeria',
    place: 'CES Sabaneta',
    additionalInformation: ':)',
    date: DateTime.now().add(Duration(hours: 2)),
    time: TimeOfDay.now(),
  ),
  Appointment(
    id: 3,
    type: 'odontologia_general',
    place: 'HGM',
    additionalInformation: ':)',
    date: DateTime.now().add(Duration(hours: 11)),
    time: TimeOfDay.now(),
  ),
  Appointment(
    id: 4,
    type: 'medicina_general',
    place: 'HPTU',
    additionalInformation: ':)',
    date: DateTime.now().add(Duration(days: 2)),
    time: TimeOfDay.now(),
  ),
  Appointment(
    id: 5,
    type: 'fisioterapia',
    place: 'HGM',
    additionalInformation: ':)',
    date: DateTime.now().add(Duration(days: 11)),
    time: TimeOfDay.now(),
  ),
  Appointment(
    id: 6,
    type: 'fonoaudiologia',
    place: 'SVF',
    additionalInformation: ':)',
    date: DateTime.now().add(Duration(days: 30)),
    time: TimeOfDay.now(),
  ),
];

List<Appointment> pastAppointments = [
  Appointment(
    id: 7,
    type: 'optometria',
    place: 'HGM',
    additionalInformation: ':)',
    date: DateTime.now().subtract(Duration(days: 12)),
    time: TimeOfDay.now(),
  ),
  Appointment(
    id: 8,
    type: 'odontologia_especializada',
    place: 'SVF',
    additionalInformation: ':)',
    date: DateTime.now().subtract(Duration(days: 4)),
    time: TimeOfDay.now(),
  ),
  Appointment(
    id: 9,
    type: 'psicologia',
    place: 'CES Sabaneta',
    additionalInformation: ':)',
    date: DateTime.now().subtract(Duration(days: 30)),
    time: TimeOfDay.now(),
  ),
  Appointment(
    id: 10,
    type: 'quimica_farmaceutica',
    place: 'HGM',
    additionalInformation: ':)',
    date: DateTime.now().subtract(Duration(days: 5)),
    time: TimeOfDay.now(),
  ),
  Appointment(
    id: 11,
    type: 'terapia_ocupacional',
    place: 'SVF',
    additionalInformation: ':)',
    date: DateTime.now().subtract(Duration(days: 1)),
    time: TimeOfDay.now(),
  ),
  Appointment(
    id: 12,
    type: 'terapia_respiratoria',
    place: 'CES Sabaneta',
    additionalInformation: ':)',
    date: DateTime.now().subtract(Duration(hours: 15)),
    time: TimeOfDay.now(),
  ),
];

int appointmentId = 13;
