import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:intl/intl.dart';

import 'package:atenciones_v2/constants/constants.dart';
import 'package:atenciones_v2/constants/gif_bank.dart';
import 'package:atenciones_v2/constants/appointment_type_data.dart';
// import 'package:atenciones_v2/models/appointment_list.dart';
import 'package:atenciones_v2/models/past_and_present_appointments.dart';
import 'package:atenciones_v2/models/appointment.dart';
import 'package:atenciones_v2/components/gif_and_btn_container.dart';
import 'package:atenciones_v2/components/form_picker.dart';
import 'package:atenciones_v2/components/appointment_date_and_time.dart';
import 'package:atenciones_v2/components/app_button.dart';
import 'package:atenciones_v2/helpers/default_appbar.dart';
import 'package:atenciones_v2/validators/validation.dart';

class NewAppointment extends StatefulWidget {
  static const id = 'new_appointment';

  @override
  _NewAppointmentState createState() => _NewAppointmentState();
}

class _NewAppointmentState extends State<NewAppointment>
    with TickerProviderStateMixin {
  int id;
  String place;
  String type;
  String additionalInformation;
  DateTime date;
  TimeOfDay time;
  String alertValue = '';

  bool isVisible = true;
  bool placeEnabled = false;
  bool typeEnabled = false;
  bool dateEnabled = false;
  bool additionalInformationEnabled = false;
  bool selectedBtn = false;
  FocusNode placeFocusNode;
  FocusNode typeFocusNode;
  FocusNode dateFocusNode;
  FocusNode additionalInformationFocusNode;

  String currentGif = 'anadir_cita';
  String gifPath = '';
  GifController controller;

  TextEditingController placeController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController additionalInformationController =
      TextEditingController();

  @override
  void initState() {
    controller = GifController(vsync: this);
    placeFocusNode = FocusNode();
    typeFocusNode = FocusNode();
    dateFocusNode = FocusNode();
    additionalInformationFocusNode = FocusNode();
    playGif(currentGif);
    super.initState();
  }

  @override
  void dispose() {
    placeFocusNode.dispose();
    typeFocusNode.dispose();
    dateFocusNode.dispose();
    additionalInformationFocusNode.dispose();
    super.dispose();
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

  saveNewAppointment() {
    FocusScope.of(context).requestFocus(FocusNode());
    final format = DateFormat.jm();

    setState(() {
      placeEnabled = true;
      typeEnabled = true;
      dateEnabled = true;
      additionalInformationEnabled = true;
    });

    if (placeController.text.isNotEmpty &&
        typeController.text.isNotEmpty &&
        dateController.text.isNotEmpty) {
      place = placeController.text;
      type = appointmentNameToType(typeController.text);
      date = DateFormat('yMd').parse(
        dateController.text.split(" - ")[0],
      );
      time = TimeOfDay.fromDateTime(
          format.parse(dateController.text.split(" - ")[1]));
      additionalInformation = additionalInformationController.text;

      final newAppointment = Appointment(
        id: appointmentId,
        type: type,
        date: date,
        time: time,
        place: place,
        additionalInformation:
            additionalInformation.isEmpty ? '' : additionalInformation,
      );

      appointmentId++;

      //Solo past y present cuando se añade, no "actualiza"
      // Unificar date y time somehow
      if (date.isAfter(DateTime.now())) {
        presentAppointments.add(newAppointment);
      } else {
        pastAppointments.add(newAppointment);
      }
      pastAppointments.sort((a, b) => a.date.compareTo(b.date));
      presentAppointments.sort((a, b) => a.date.compareTo(b.date));

      Navigator.pop(context);
    } //VALIDADOR
  }

  disableAllTextForms() {
    setState(() {
      placeEnabled = false;
      typeEnabled = false;
      dateEnabled = false;
      additionalInformationEnabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;

    return
        // WillPopScope(
        //   onWillPop: () {
        //     return;
        //   }, //VALIDATOR
        //   child:
        Scaffold(
      // backgroundColor: kBackgroundColor,
      backgroundColor: kLightGrey,
      appBar: defaultAppBar('Nueva atención', true),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.focusedChild.unfocus();
          }
          disableAllTextForms();
        },
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              placeEnabled = false;
                              typeEnabled = true;
                              dateEnabled = false;
                              additionalInformationEnabled = false;
                            });
                            playGif('elegir_tipo_de_cita');
                          },
                          child: FormPicker(
                            hintTxt: 'Tipo de atención',
                            selectedItem: type,
                            itemsList: appointmentTypes,
                            textController: typeController,
                            isMandatory: true,
                            isEnabled: typeEnabled,
                            pickerFocusNode: typeFocusNode,
                            disablePicker: () {
                              setState(() {
                                typeEnabled = false;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              placeEnabled = false;
                              typeEnabled = false;
                              dateEnabled = true;
                              additionalInformationEnabled = false;
                            });
                            playGif('elegir_fecha_y_hora');
                          },
                          child: AppointmentDateAndTime(
                            hintTxt: 'Fecha y hora de la cita',
                            textController: dateController,
                            isEnabled: dateEnabled,
                            pickerFocusNode: dateFocusNode,
                            appointmentDate: date,
                            appointmentTime: time,
                            disableAppointmentDateAndTime: () {
                              setState(() {
                                dateEnabled = false;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              placeEnabled = true;
                              typeEnabled = false;
                              dateEnabled = false;
                              additionalInformationEnabled = false;
                            });
                            playGif('digitar_lugar_cita');
                          },
                          child: TextFormField(
                            onTap: () {
                              setState(() {
                                isVisible = false;
                              });
                              playGif('digitar_lugar_cita');
                            },
                            onEditingComplete: () {
                              setState(() {
                                isVisible = true;
                                placeEnabled = false;
                              });
                            },
                            enabled: placeEnabled,
                            focusNode: placeFocusNode,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.center,
                            style: kTextFormFieldStyle,
                            onChanged: (value) {
                              place = value;
                            },
                            validator: (value) {
                              return Validator()
                                  .validatePasswordField(value); //CHECK
                            },
                            decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Ingresa el lugar de tu cita',
                              hintStyle: kTextFormFieldStyle,
                            ),
                            controller: placeController,
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              placeEnabled = false;
                              typeEnabled = false;
                              dateEnabled = false;
                              additionalInformationEnabled = true;
                            });
                            playGif('digitar_informacion_adicional');
                          },
                          child: TextFormField(
                            onTap: () {
                              setState(() {
                                isVisible = false;
                              });
                              playGif('digitar_informacion_adicional');
                            },
                            onEditingComplete: () {
                              setState(() {
                                isVisible = true;
                                additionalInformationEnabled = false;
                              });
                            },
                            enabled: additionalInformationEnabled,
                            focusNode: additionalInformationFocusNode,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.center,
                            obscureText: false,
                            style: kTextFormFieldStyle,
                            onChanged: (value) {
                              additionalInformation = value;
                            },
                            validator: (value) {
                              return Validator()
                                  .validatePasswordField(value); //CHECK
                            },
                            decoration: kTextFieldDecoration.copyWith(
                              hintText:
                                  'Ingresa información adicional (opcional)',
                              hintStyle: kTextFormFieldStyle,
                            ),
                            controller: additionalInformationController,
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.07),
                          child: AppButton(
                            btnColor: kDarkBlue,
                            btnBorderColor: selectedBtn
                                ? kActiveBtnColor
                                : Colors.transparent,
                            title: 'Guardar',
                            textColor: Colors.white,
                            onPress: () {
                              playGif('guardar');
                              setState(() {
                                disableAllTextForms();
                                selectedBtn = true;
                              });
                            },
                            onDoublePress: saveNewAppointment,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GifAndBtnContainer(
                  controller: controller,
                  gif: gifPath,
                  isVisible: !isKeyboardShowing,
                  onTap: () {
                    switch (currentGif) {
                      case 'elegir_tipo_de_cita':
                        {
                          typeFocusNode.requestFocus();
                        }
                        break;

                      case 'elegir_fecha_y_hora':
                        {
                          dateFocusNode.requestFocus();
                        }
                        break;

                      case 'digitar_lugar_cita':
                        {
                          placeFocusNode.requestFocus();
                        }
                        break;

                      case 'digitar_informacion_adicional':
                        {
                          additionalInformationFocusNode.requestFocus();
                        }
                        break;

                      case 'guardar':
                        {
                          saveNewAppointment();
                        }
                        break;
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      // ),
    );
  }
}
