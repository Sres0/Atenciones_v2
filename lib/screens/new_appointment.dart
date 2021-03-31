import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';

import 'package:atenciones_v2/constants/constants.dart';
import 'package:atenciones_v2/constants/gif_bank.dart';
import 'package:atenciones_v2/constants/appointment_type_data.dart';
// import 'package:atenciones_v2/models/appointment_list.dart';
// import 'package:atenciones_v2/models/appointment.dart';
import 'package:atenciones_v2/components/gif_and_btn_container.dart';
import 'package:atenciones_v2/components/form_picker.dart';
// import 'package:atenciones_v2/components/app_button.dart';
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
  bool additionalInformationEnabled = false;
  bool selectedBtn = false;
  FocusNode placeFocusNode;
  FocusNode typeFocusNode;
  FocusNode additionalInformationFocusNode;

  String currentGif = 'anadir_cita';
  String gifPath = '';
  GifController controller;

  TextEditingController placeController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController additionalInformationController =
      TextEditingController();

  @override
  void initState() {
    controller = GifController(vsync: this);
    placeFocusNode = FocusNode();
    typeFocusNode = FocusNode();
    additionalInformationFocusNode = FocusNode();
    playGif(currentGif);
    super.initState();
  }

  @override
  void dispose() {
    placeFocusNode.dispose();
    typeFocusNode.dispose();
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

  disableAllTextForms() {
    setState(() {
      placeEnabled = false;
      typeEnabled = false;
      additionalInformationEnabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // bool isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;

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
          // FocusScopeNode currentFocus = FocusScope.of(context);
          // if (!currentFocus.hasPrimaryFocus &&
          //     currentFocus.focusedChild != null) {
          //   currentFocus.focusedChild.unfocus();
          // }
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
                              additionalInformationEnabled = false;
                            });
                            playGif('anadir_cita'); //CHECK
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
                              print(typeController);
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
                              additionalInformationEnabled = false;
                            });
                            playGif('anadir_cita'); //CHECK
                          },
                          child: TextFormField(
                            onTap: () {
                              setState(() {
                                isVisible = false;
                              });
                              playGif('anadir_cita'); //CHECK
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
                              additionalInformationEnabled = true;
                            });
                            playGif('anadir_cita'); //CHECK
                          },
                          child: TextFormField(
                            onTap: () {
                              setState(() {
                                isVisible = false;
                              });

                              playGif('anadir_cita'); //CHECK
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
                      ],
                    ),
                  ),
                ),
                GifAndBtnContainer(
                  controller: controller,
                  gif: gifPath,
                  isVisible: isVisible,
                  onTap: () {},
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

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:flutter_gifimage/flutter_gifimage.dart';
// import 'package:modal_progress_hud/modal_progress_hud.dart';

// import 'package:lsc_app/components/app_button.dart';
// import 'package:lsc_app/components/date_picker.dart';
// import 'package:lsc_app/components/form_picker.dart';
// import 'package:lsc_app/components/gif_and_btn_container.dart';
// import 'package:lsc_app/components/icon_content.dart';
// import 'package:lsc_app/components/reusable_card.dart';
// import 'package:lsc_app/constants/constants.dart';
// import 'package:lsc_app/constants/form_data.dart';
// import 'package:lsc_app/firebase/firebase_functions.dart';
// import 'package:lsc_app/main.dart';
// import 'package:lsc_app/screens/main_screen.dart';
// import 'package:lsc_app/helpers/default_appbar.dart';
// import 'package:lsc_app/validators/validation.dart';

// class FormScreen extends StatefulWidget {
//   static const id = 'form_screen';

//   @override
//   _FormScreenState createState() => _FormScreenState();
// }

// class _FormScreenState extends State<FormScreen> with TickerProviderStateMixin {
//   bool showSpinner = false;
//   Gender selectedGender;
//   String tappedGenderBtn;

//   String firstName = '';
//   String lastName = '';
//   String sex = '';
//   String depto = '';
//   String municipio = '';
//   String birthDate = '';
//   String phoneNumber = '';
//   String mobileNumber = '';
//   String email = '';
//   String eps = '';

//   String currentGif = 'formulario_inscripcion';
//   String gifPath = '';
//   GifController controller;

//   bool firstNameEnabled = false;
//   bool lastNameEnabled = false;
//   bool deptoEnabled = false;
//   bool municipioEnabled = false;
//   bool birthDateEnabled = false;
//   bool phoneNumberEnabled = false;
//   bool mobileNumberEnabled = false;
//   bool emailEnabled = false;
//   bool epsEnabled = false;
//   bool selectedBtn = false;

//   FocusNode firstNameFocusNode;
//   FocusNode lastNameFocusNode;
//   FocusNode deptoFocusNode;
//   FocusNode municipioFocusNode;
//   FocusNode birthDateFocusNode;
//   FocusNode phoneNumberFocusNode;
//   FocusNode mobileNumberFocusNode;
//   FocusNode emailFocusNode;
//   FocusNode epsFocusNode;

//   List<String> updatedList = [''];

//   TextEditingController firstNameController = TextEditingController();
//   TextEditingController lastNameController = TextEditingController();
//   TextEditingController deptoController = TextEditingController();
//   TextEditingController municipioController = TextEditingController();
//   TextEditingController birthDateController = TextEditingController();
//   TextEditingController phoneNumberController = TextEditingController();
//   TextEditingController mobileNumberController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController epsController = TextEditingController();

//   final _formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     deptoController.addListener(() {
//       updateList();
//     });

//     controller = GifController(vsync: this);

//     firstNameFocusNode = FocusNode();
//     lastNameFocusNode = FocusNode();
//     deptoFocusNode = FocusNode();
//     municipioFocusNode = FocusNode();
//     birthDateFocusNode = FocusNode();
//     phoneNumberFocusNode = FocusNode();
//     mobileNumberFocusNode = FocusNode();
//     emailFocusNode = FocusNode();
//     epsFocusNode = FocusNode();

//     playGif(currentGif);

//     super.initState();
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     deptoController.dispose();

//     firstNameFocusNode.dispose();
//     lastNameFocusNode.dispose();
//     deptoFocusNode.dispose();
//     municipioFocusNode.dispose();
//     birthDateFocusNode.dispose();
//     phoneNumberFocusNode.dispose();
//     mobileNumberFocusNode.dispose();
//     emailFocusNode.dispose();
//     epsFocusNode.dispose();

//     super.dispose();
//   }

//   updateList() {
//     if (deptoController.text != '') {
//       municipiosList.forEach((d) {
//         String deptoName = d.values.toList()[1];
//         if (deptoName == deptoController.text) {
//           setState(() {
//             updatedList = d.values.toList()[2];
//           });
//         }
//       });
//     }
//   }

//   playGif(String gifToPlay) {
//     double frameNum = 0.0;
//     controller.value = 0;

//     gifBank.gifs.forEach((gif) {
//       if (gifToPlay == gif.name) {
//         frameNum = gif.frames - 1;
//         setState(() {
//           currentGif = gif.name;
//           gifPath = gif.image(gif.name, gif.frames);
//         });

//         controller.animateTo(frameNum,
//             duration: Duration(milliseconds: (140 * frameNum).toInt()));
//       }
//     });
//   }

//   registerNewUser() {
//     FocusScope.of(context).requestFocus(FocusNode());

//     setState(() {
//       firstNameEnabled = true;
//       lastNameEnabled = true;
//       deptoEnabled = true;
//       municipioEnabled = true;
//       birthDateEnabled = true;
//       phoneNumberEnabled = true;
//       mobileNumberEnabled = true;
//       emailEnabled = true;
//       epsEnabled = true;
//     });

//     if (_formKey.currentState.validate()) {
//       setState(() {
//         showSpinner = true;
//       });

//       firstName = firstNameController.text;
//       lastName = lastNameController.text;
//       sex = selectedGender.toString().split(".")[1];
//       depto = deptoController.text;
//       municipio = municipioController.text;
//       birthDate = birthDateController.text;
//       phoneNumber = phoneNumberController.text;
//       mobileNumber = mobileNumberController.text;
//       email = emailController.text;
//       eps = epsController.text;

//       try {
//         FirebaseFunctions().createUser(firstName, lastName, sex, depto,
//             municipio, birthDate, phoneNumber, mobileNumber, email, eps);
//         Navigator.pushNamed(context, MainScreen.id);
//       } catch (e) {
//         print(e);
//       } finally {
//         setState(() {
//           showSpinner = false;
//         });
//       }
//     }
//   }

//   disableAllTextForms() {
//     setState(() {
//       firstNameEnabled = false;
//       lastNameEnabled = false;
//       deptoEnabled = false;
//       municipioEnabled = false;
//       birthDateEnabled = false;
//       phoneNumberEnabled = false;
//       mobileNumberEnabled = false;
//       emailEnabled = false;
//       epsEnabled = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;

//     return WillPopScope(
//       onWillPop: () async => false,
//       child: Scaffold(
//         backgroundColor: kBackgroundColor,
//         appBar: defaultAppBar('Formulario de Inscripción', false),
//         body: GestureDetector(
//           onTap: () {
//             FocusScopeNode currentFocus = FocusScope.of(context);
//             if (!currentFocus.hasPrimaryFocus &&
//                 currentFocus.focusedChild != null) {
//               currentFocus.focusedChild.unfocus();
//             }
//             disableAllTextForms();
//           },

//           child: ModalProgressHUD(
//             inAsyncCall: showSpinner,
//             child: SafeArea(
//               child: Form(
//                 key: _formKey,
//                 child: Scrollbar(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Expanded(
//                         child: Container(
//                           padding: EdgeInsets.symmetric(
//                               horizontal:
//                                   MediaQuery.of(context).size.width * 0.1,
//                               vertical: 10.0),
//                           child: Center(

//                             child: ListView(
//                               children: [
//                                 GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       firstNameEnabled = true;
//                                       lastNameEnabled = false;
//                                       deptoEnabled = false;
//                                       municipioEnabled = false;
//                                       birthDateEnabled = false;
//                                       phoneNumberEnabled = false;
//                                       mobileNumberEnabled = false;
//                                       emailEnabled = false;
//                                       epsEnabled = false;
//                                       selectedBtn = false;
//                                       tappedGenderBtn = '';
//                                     });
//                                     playGif('nombres');
//                                   },
//                                   child: TextFormField(
//                                     onTap: () {
//                                       playGif('nombres');
//                                     },
//                                     onEditingComplete: () {
//                                       setState(() {
//                                         firstNameEnabled = false;
//                                       });
//                                     },
//                                     enabled: firstNameEnabled,
//                                     focusNode: firstNameFocusNode,
//                                     keyboardType: TextInputType.name,
//                                     textCapitalization:
//                                         TextCapitalization.words,
//                                     textAlign: TextAlign.center,
//                                     style: kTextFormFieldStyle,
//                                     decoration: kTextFieldDecoration.copyWith(
//                                       hintText: 'Nombres',
//                                       hintStyle: kTextFormFieldStyle,
//                                     ),
//                                     validator: (value) {
//                                       return Validator()
//                                           .validateTextField(value);
//                                     },
//                                     controller: firstNameController,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 20.0,
//                                 ),

//                                 GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       firstNameEnabled = false;
//                                       lastNameEnabled = true;
//                                       deptoEnabled = false;
//                                       municipioEnabled = false;
//                                       birthDateEnabled = false;
//                                       phoneNumberEnabled = false;
//                                       mobileNumberEnabled = false;
//                                       emailEnabled = false;
//                                       epsEnabled = false;
//                                       selectedBtn = false;
//                                       tappedGenderBtn = '';
//                                     });
//                                     playGif('apellidos');
//                                   },
//                                   child: TextFormField(
//                                     onTap: () {
//                                       playGif('apellidos');
//                                     },
//                                     onEditingComplete: () {
//                                       setState(() {
//                                         lastNameEnabled = false;
//                                       });
//                                     },
//                                     enabled: lastNameEnabled,
//                                     focusNode: lastNameFocusNode,
//                                     keyboardType: TextInputType.name,
//                                     textCapitalization:
//                                         TextCapitalization.words,
//                                     textAlign: TextAlign.center,
//                                     style: kTextFormFieldStyle,
//                                     decoration: kTextFieldDecoration.copyWith(
//                                       hintText: 'Apellidos',
//                                       hintStyle: kTextFormFieldStyle,
//                                     ),
//                                     validator: (value) {
//                                       return Validator()
//                                           .validateTextField(value);
//                                     },
//                                     controller: lastNameController,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 20.0,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: <Widget>[
//                                     Expanded(
//                                       child: ReusableCard(
//                                         colour:
//                                             selectedGender == Gender.Masculino
//                                                 ? kActiveCardColor
//                                                 : kInactiveCardColor,
//                                         borderColor: tappedGenderBtn == 'hombre'
//                                             ? kActiveBorderColor
//                                             : kInactiveBorderColor
//                                                 .withOpacity(0.3),
//                                         cardChild: IconContent(
//                                           icon: FontAwesomeIcons.mars,
//                                           iconText: 'Hombre',
//                                         ),
//                                         onPress: () {
//                                           disableAllTextForms();
//                                           playGif('hombre');
//                                           setState(() {
//                                             tappedGenderBtn = 'hombre';
//                                             selectedBtn = false;
//                                           });
//                                         },
//                                         onDoublePress: () {
//                                           disableAllTextForms();
//                                           setState(() {
//                                             selectedGender = Gender.Masculino;
//                                             tappedGenderBtn = 'hombre';
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: ReusableCard(
//                                         colour:
//                                             selectedGender == Gender.Femenino
//                                                 ? kActiveCardColor
//                                                 : kInactiveCardColor,
//                                         borderColor: tappedGenderBtn == 'mujer'
//                                             ? kActiveBorderColor
//                                             : kInactiveBorderColor
//                                                 .withOpacity(0.3),
//                                         cardChild: IconContent(
//                                           icon: FontAwesomeIcons.venus,
//                                           iconText: 'Mujer',
//                                         ),
//                                         onPress: () {
//                                           disableAllTextForms();
//                                           playGif('mujer');
//                                           setState(() {
//                                             tappedGenderBtn = 'mujer';
//                                             selectedBtn = false;
//                                           });
//                                         },
//                                         onDoublePress: () {
//                                           disableAllTextForms();
//                                           setState(() {
//                                             selectedGender = Gender.Femenino;
//                                             tappedGenderBtn = 'mujer';
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 20.0,
//                                 ),

//                                 GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       firstNameEnabled = false;
//                                       lastNameEnabled = false;
//                                       deptoEnabled = true;
//                                       municipioEnabled = false;
//                                       birthDateEnabled = false;
//                                       phoneNumberEnabled = false;
//                                       mobileNumberEnabled = false;
//                                       emailEnabled = false;
//                                       epsEnabled = false;
//                                       selectedBtn = false;
//                                       tappedGenderBtn = '';
//                                     });
//                                     playGif('departamento');
//                                   },
//                                   child: FormPicker(
//                                     hintTxt: 'Departamento',
//                                     selectedItem: depto,
//                                     itemsList: departamentosList,
//                                     textController: deptoController,
//                                     isMandatory: false,
//                                     isEnabled: deptoEnabled,
//                                     pickerFocusNode: deptoFocusNode,
//                                     disablePicker: () {
//                                       setState(() {
//                                         deptoEnabled = false;
//                                       });
//                                     },
//                                   ),
//                                 ),

//                                 SizedBox(
//                                   height: 20.0,
//                                 ),
//                                 GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       firstNameEnabled = false;
//                                       lastNameEnabled = false;
//                                       deptoEnabled = false;
//                                       municipioEnabled = true;
//                                       birthDateEnabled = false;
//                                       phoneNumberEnabled = false;
//                                       mobileNumberEnabled = false;
//                                       emailEnabled = false;
//                                       epsEnabled = false;
//                                       selectedBtn = false;
//                                       tappedGenderBtn = '';
//                                     });
//                                     playGif('municipio');
//                                   },
//                                   child: FormPicker(
//                                     hintTxt: 'Ciudad',
//                                     selectedItem: municipio,
//                                     itemsList: updatedList,
//                                     textController: municipioController,
//                                     isMandatory: false,
//                                     isEnabled: municipioEnabled,
//                                     pickerFocusNode: municipioFocusNode,
//                                     disablePicker: () {
//                                       setState(() {
//                                         municipioEnabled = false;
//                                       });
//                                     },
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 20.0,
//                                 ),

//                                 GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       firstNameEnabled = false;
//                                       lastNameEnabled = false;
//                                       deptoEnabled = false;
//                                       municipioEnabled = false;
//                                       birthDateEnabled = true;
//                                       phoneNumberEnabled = false;
//                                       mobileNumberEnabled = false;
//                                       emailEnabled = false;
//                                       epsEnabled = false;
//                                       selectedBtn = false;
//                                       tappedGenderBtn = '';
//                                     });
//                                     playGif('fecha_de_nacimiento');
//                                   },
//                                   child: DatePicker(
//                                     hintTxt: 'Fecha de Nacimiento',
//                                     textController: birthDateController,
//                                     isEnabled: birthDateEnabled,
//                                     pickerFocusNode: birthDateFocusNode,
//                                     disableDatePicker: () {
//                                       setState(() {
//                                         birthDateEnabled = false;
//                                       });
//                                     },
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 20.0,
//                                 ),
//                                 GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       firstNameEnabled = false;
//                                       lastNameEnabled = false;
//                                       deptoEnabled = false;
//                                       municipioEnabled = false;
//                                       birthDateEnabled = false;
//                                       phoneNumberEnabled = false;
//                                       mobileNumberEnabled = true;
//                                       emailEnabled = false;
//                                       epsEnabled = false;
//                                       selectedBtn = false;
//                                       tappedGenderBtn = '';
//                                     });
//                                     playGif('celular');
//                                   },
//                                   child: TextFormField(
//                                     onTap: () {
//                                       playGif('celular');
//                                     },
//                                     onEditingComplete: () {
//                                       setState(() {
//                                         mobileNumberEnabled = false;
//                                       });
//                                     },
//                                     enabled: mobileNumberEnabled,
//                                     focusNode: mobileNumberFocusNode,
//                                     keyboardType: TextInputType.phone,
//                                     inputFormatters: [
//                                       FilteringTextInputFormatter.digitsOnly,
//                                     ],
//                                     textAlign: TextAlign.center,
//                                     style: kTextFormFieldStyle,
//                                     decoration: kTextFieldDecoration.copyWith(
//                                       hintText: 'Número de WhatsApp',
//                                       hintStyle: kTextFormFieldStyle,
//                                     ),
//                                     validator: (value) {
//                                       return Validator()
//                                           .validateMobilePhoneField(value);
//                                     },
//                                     controller: mobileNumberController,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 20.0,
//                                 ),
//                                 GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       firstNameEnabled = false;
//                                       lastNameEnabled = false;
//                                       deptoEnabled = false;
//                                       municipioEnabled = false;
//                                       birthDateEnabled = false;
//                                       phoneNumberEnabled = false;
//                                       mobileNumberEnabled = false;
//                                       emailEnabled = true;
//                                       epsEnabled = false;
//                                       selectedBtn = false;
//                                       tappedGenderBtn = '';
//                                     });
//                                     playGif('correo');
//                                   },
//                                   child: TextFormField(
//                                     onTap: () {
//                                       playGif('correo');
//                                     },
//                                     onEditingComplete: () {
//                                       setState(() {
//                                         emailEnabled = false;
//                                       });
//                                     },
//                                     enabled: emailEnabled,
//                                     focusNode: emailFocusNode,
//                                     keyboardType: TextInputType.emailAddress,
//                                     textAlign: TextAlign.center,
//                                     style: kTextFormFieldStyle,
//                                     decoration: kTextFieldDecoration.copyWith(
//                                       hintText: 'Correo Electrónico',
//                                       hintStyle: kTextFormFieldStyle,
//                                     ),
//                                     validator: (value) {
//                                       return Validator()
//                                           .validateEmailField(value);
//                                     },
//                                     controller: emailController,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 20.0,
//                                 ),
//                                 GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       firstNameEnabled = false;
//                                       lastNameEnabled = false;
//                                       deptoEnabled = false;
//                                       municipioEnabled = false;
//                                       birthDateEnabled = false;
//                                       phoneNumberEnabled = false;
//                                       mobileNumberEnabled = false;
//                                       emailEnabled = false;
//                                       epsEnabled = true;
//                                       selectedBtn = false;
//                                       tappedGenderBtn = '';
//                                     });
//                                     playGif('eps');
//                                   },
//                                   child: TextFormField(
//                                     onTap: () {
//                                       playGif('eps');
//                                     },
//                                     onEditingComplete: () {
//                                       setState(() {
//                                         epsEnabled = false;
//                                       });
//                                     },
//                                     enabled: epsEnabled,
//                                     focusNode: epsFocusNode,
//                                     textCapitalization:
//                                         TextCapitalization.words,
//                                     textAlign: TextAlign.center,
//                                     style: kTextFormFieldStyle,
//                                     decoration: kTextFieldDecoration.copyWith(
//                                       hintText: 'Nombre E.P.S.',
//                                       hintStyle: kTextFormFieldStyle,
//                                     ),
//                                     validator: (value) {
//                                       return Validator()
//                                           .validateEPSField(value);
//                                     },
//                                     controller: epsController,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(
//                             horizontal:
//                                 MediaQuery.of(context).size.width * 0.07),
//                         child: AppButton(
//                           btnColor: kDarkBlue,
//                           btnBorderColor: selectedBtn
//                               ? kActiveBtnColor
//                               : Colors.transparent,
//                           title: 'Guardar',
//                           textColor: Colors.white,
//                           onPress: () {
//                             playGif('guardar_informacion');
//                             disableAllTextForms();
//                             setState(() {
//                               setState(() {
//                                 firstNameEnabled = false;
//                                 lastNameEnabled = false;
//                                 deptoEnabled = false;
//                                 municipioEnabled = false;
//                                 birthDateEnabled = false;
//                                 phoneNumberEnabled = false;
//                                 mobileNumberEnabled = false;
//                                 emailEnabled = false;
//                                 epsEnabled = false;
//                                 selectedBtn = true;
//                                 tappedGenderBtn = '';
//                               });
//                             });
//                           },
//                           onDoublePress: registerNewUser,
//                         ),
//                       ),
//                       GifAndBtnContainer(
//                         controller: controller,
//                         gif: gifPath,
//                         isVisible: !isKeyboardShowing,
//                         onTap: () {
//                           switch (currentGif) {
//                             case 'nombres':
//                               {
//                                 firstNameFocusNode.requestFocus();
//                               }
//                               break;

//                             case 'apellidos':
//                               {
//                                 lastNameFocusNode.requestFocus();
//                               }
//                               break;

//                             case 'hombre':
//                               {
//                                 setState(() {
//                                   selectedGender = Gender.Masculino;
//                                 });
//                               }
//                               break;

//                             case 'mujer':
//                               {
//                                 setState(() {
//                                   selectedGender = Gender.Femenino;
//                                 });
//                               }
//                               break;

//                             case 'departamento':
//                               {
//                                 deptoFocusNode.requestFocus();
//                               }
//                               break;

//                             case 'municipio':
//                               {
//                                 municipioFocusNode.requestFocus();
//                               }
//                               break;

//                             case 'fecha_de_nacimiento':
//                               {
//                                 birthDateFocusNode.requestFocus();
//                               }
//                               break;

//                             case 'celular':
//                               {
//                                 mobileNumberFocusNode.requestFocus();
//                               }
//                               break;

//                             case 'correo':
//                               {
//                                 emailFocusNode.requestFocus();
//                               }
//                               break;

//                             case 'eps':
//                               {
//                                 epsFocusNode.requestFocus();
//                               }
//                               break;

//                             case 'guardar_informacion':
//                               {
//                                 registerNewUser();
//                               }
//                               break;

//                             default:
//                               {
//                                 firstNameFocusNode.requestFocus();
//                               }
//                               break;
//                           }
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
