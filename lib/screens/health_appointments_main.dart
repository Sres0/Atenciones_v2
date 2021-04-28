import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';

import 'package:atenciones_v2/constants/constants.dart';
import 'package:atenciones_v2/constants/gif_bank.dart';
import 'package:atenciones_v2/models/appointment_list.dart';
import 'package:atenciones_v2/models/appointment.dart';
import 'package:atenciones_v2/models/past_and_present_appointments.dart';
import 'package:atenciones_v2/components/gif_and_btn_container.dart';
import 'package:atenciones_v2/components/app_button.dart';
import 'package:atenciones_v2/helpers/default_appbar.dart';
import 'package:atenciones_v2/screens/new_appointment.dart';
import 'package:atenciones_v2/screens/individual_appointment.dart';
// import 'package:atenciones_v2/screens/practice.dart';

class HealthAppointments extends StatefulWidget {
  static const id = 'health_appointments_main';

  @override
  _HealthAppointmentsState createState() => _HealthAppointmentsState();
}

class _HealthAppointmentsState extends State<HealthAppointments>
    with TickerProviderStateMixin {
  int _bottomNavigationIndex = 0;

  Function proceed = () {};

  List<Appointment> renderList;

  String currentGif = 'citas_pendientes';
  String gifPath = '';
  GifController controller;

  bool selectedBtn = false;

  @override
  void initState() {
    controller = GifController(vsync: this);
    playGif(currentGif);
    presentAppointments.forEach((element) {
      print('elemento');
      if (element.date.isBefore(DateTime.now())) {
        presentAppointments.remove(element);
        pastAppointments.add(element);
      }
    });
    renderList = presentAppointments;
    super.initState();
  }

  playGif(String gifToPlay) {
    double frameNum = 0.0;
    controller.value = 0;

    GifBank().gifs.forEach((gif) {
      if (gifToPlay == gif.name) {
        frameNum = gif.frames - 1;

        setState(() {
          currentGif = gif.name;
          gifPath = gif.image(gif.name, gif.frames);
        });

        controller.animateTo(frameNum,
            duration: Duration(milliseconds: (140 * frameNum).toInt()));
      }
    });
  }

  _selectAppointmentList(int index) {
    setState(() {
      if (index == 0) {
        playGif('citas_pendientes');
        renderList = presentAppointments;
        _bottomNavigationIndex = 0;
      } else {
        playGif('citas_pasadas');
        renderList = pastAppointments;
        _bottomNavigationIndex = 1;
      }
    });
  }

  void _deleteAppointment(int id) {
    setState(() {
      pastAppointments.removeWhere((appointment) => appointment.id == id);
      presentAppointments.removeWhere((appointment) => appointment.id == id);
    });
  }

  void viewAppointment(Appointment appointment) {
    proceed = () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => IndividualAppointment(appointment: appointment),
        ),
      );
    };
  }

  void reloadLists(
    List<Appointment> presentAppointments,
    List<Appointment> pastAppointments,
  ) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kBackgroundColor,
      backgroundColor: kLightGrey,
      appBar: defaultAppBar('Atenciones', true),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        onTap: _selectAppointmentList,
        currentIndex: _bottomNavigationIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'Pendientes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Historial',
          ),
        ],
        selectedItemColor: kDarkBlue,
        unselectedItemColor: Colors.grey,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: [
                    AppButton(
                      btnColor: kDarkBlue,
                      btnBorderColor:
                          selectedBtn ? kActiveBtnColor : Colors.transparent,
                      title: '+',
                      textColor: Colors.white,
                      onPress: () {
                        setState(() {
                          selectedBtn = true;
                          playGif('anadir_cita');
                        });
                        proceed = () {
                          Navigator.pushNamed(context, NewAppointment.id);
                        };
                      },
                      onDoublePress: () {
                        setState(
                          () {
                            selectedBtn = false;
                          },
                        );
                        Navigator.pushNamed(context, NewAppointment.id);
                      },
                    ),
                    AppointmentList(
                      _deleteAppointment,
                      playGif,
                      renderList,
                      viewAppointment,
                    ),
                  ],
                ),
              ),
              GifAndBtnContainer(
                controller: controller,
                gif: gifPath,
                isVisible: true,
                onTap: proceed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
