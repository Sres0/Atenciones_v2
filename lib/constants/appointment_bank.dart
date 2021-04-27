import 'package:atenciones_v2/models/appointment_type.dart';

class AppointmentBank {
  List<AppointmentType> appointmentTypes = [
    AppointmentType(
      type: 'enfermeria',
      name: 'Enfermería',
    ),
    AppointmentType(
      type: 'fisioterapia',
      name: 'Fisioterapia',
    ),
    AppointmentType(
      type: 'fonoaudiologia',
      name: 'Fonoaudiología',
    ),
    AppointmentType(
      type: 'medicina_especializada',
      name: 'Medicina especializada',
    ),
    AppointmentType(
      type: 'medicina_general',
      name: 'Medicina general',
    ),
    AppointmentType(
      type: 'nutricion',
      name: 'Nutrición',
    ),
    AppointmentType(
      type: 'odontologia_especializada',
      name: 'Odontología especializada',
    ),
    AppointmentType(
      type: 'odontologia_general',
      name: 'Odontología general',
    ),
    AppointmentType(
      type: 'optometria',
      name: 'Optometría',
    ),
    AppointmentType(
      type: 'psicologia',
      name: 'Psicología',
    ),
    AppointmentType(
      type: 'quimica_farmaceutica',
      name: 'Química farmacéutica',
    ),
    AppointmentType(
      type: 'terapia_ocupacional',
      name: 'Terapia ocupacional',
    ),
    AppointmentType(
      type: 'terapia_respiratoria',
      name: 'Terapia respiratoria',
    ),
  ];
}
