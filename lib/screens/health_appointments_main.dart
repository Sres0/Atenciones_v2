import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';

import 'package:atenciones_v2/models/appointment_list.dart';
import 'package:atenciones_v2/constants/constants.dart';
import 'package:atenciones_v2/helpers/default_appbar.dart';
import 'package:atenciones_v2/models/appointment.dart';
import 'package:atenciones_v2/constants/gif_bank.dart';
import 'package:atenciones_v2/components/gif_and_btn_container.dart';
import 'package:atenciones_v2/components/app_button.dart';

class HealthAppointments extends StatefulWidget {
  static const id = 'health_appointments_main';

  @override
  _HealthAppointmentsState createState() => _HealthAppointmentsState();
}

class _HealthAppointmentsState extends State<HealthAppointments>
    with TickerProviderStateMixin {
  int _bottomNavigationIndex = 0;

  List<Appointment> presentAppointments = [
    //IMPORT
    Appointment(
      id: 0,
      type: 'medicina_general',
      place: 'HGM',
      additionalInformation: ':)',
      date: DateTime.now().add(Duration(hours: 2)),
      time: TimeOfDay.now(),
    ),
    Appointment(
      id: 2,
      type: 'odontologia_general',
      place: 'HGM',
      additionalInformation: ':)',
      date: DateTime.now().add(Duration(days: 11)),
      time: TimeOfDay.now(),
    ),
  ];
  List<Appointment> pastAppointments = [
    //IMPORT
    Appointment(
      id: 1,
      type: 'medicina_general',
      place: 'CES Sabaneta',
      additionalInformation: ':)',
      date: DateTime.now().subtract(Duration(days: 12)),
      time: TimeOfDay.now(),
    ),
    Appointment(
      id: 3,
      type: 'odontologia_general',
      place: 'CES Sabaneta',
      additionalInformation: ':)',
      date: DateTime.now().subtract(Duration(days: 4)),
      time: TimeOfDay.now(),
    ),
  ];
  List<Appointment> renderList = [];

  String currentGif = 'citas_pendientes';
  String gifPath = '';
  GifController controller;

  bool selectedBtn = false;

  @override
  void initState() {
    renderList = presentAppointments; //WEIRD

    controller = GifController(vsync: this);
    playGif(currentGif);
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
    // return;
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
              AppButton(
                btnColor: kDarkBlue,
                btnBorderColor:
                    selectedBtn ? kActiveBtnColor : Colors.transparent,
                title: '+',
                textColor: Colors.white,
                onPress: () {
                  setState(
                    () {
                      selectedBtn = true;
                      playGif('anadir_cita');
                    },
                  );
                },
                onDoublePress: () {},
              ),
              AppointmentList(
                _deleteAppointment,
                playGif,
                renderList,
              ),
              GifAndBtnContainer(
                controller: controller,
                gif: gifPath,
                isVisible: true,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
