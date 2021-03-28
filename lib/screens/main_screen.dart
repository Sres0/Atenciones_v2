import 'package:flutter/material.dart';
import 'package:atenciones_v2/screens/health_appointments_main.dart';
import 'package:atenciones_v2/helpers/default_appbar.dart';
import 'package:atenciones_v2/constants/constants.dart';

class MainScreen extends StatelessWidget {
  static const id = 'health_appointments';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBlue,
      appBar: defaultAppBar('Main', true),
      body: Center(
        child: ElevatedButton(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Atenciones en salud',
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, HealthAppointments.id);
            }),
      ),
    );
  }
}
