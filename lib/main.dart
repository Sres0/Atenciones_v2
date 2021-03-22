import 'package:flutter/material.dart';
import 'package:atenciones_v2/screens/main_screen.dart';
import 'package:atenciones_v2/screens/health_appointments.dart';

void main() {
  runApp(LSCApp());
}

class LSCApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LSC App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
      routes: {
        MainScreen.id: (context) => MainScreen(),
        HealthAppointments.id: (context) => HealthAppointments(),
      },
    );
  }
}
