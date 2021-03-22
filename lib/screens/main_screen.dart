import 'package:flutter/material.dart';
import 'package:atenciones_v2/screens/health_appointments.dart';

class MainScreen extends StatelessWidget {
  static const id = 'health_appointments';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
