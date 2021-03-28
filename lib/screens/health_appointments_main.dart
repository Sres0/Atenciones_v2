import 'package:atenciones_v2/constants/test_appointments_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';

import 'package:atenciones_v2/constants/constants.dart';
import 'package:atenciones_v2/helpers/default_appbar.dart';
import 'package:atenciones_v2/models/appointment_model.dart';
import 'package:atenciones_v2/constants/gif_bank.dart';

class HealthAppointments extends StatefulWidget {
  static const id = 'health_appointments_main';

  @override
  _HealthAppointmentsState createState() => _HealthAppointmentsState();
}

class _HealthAppointmentsState extends State<HealthAppointments>
    with TickerProviderStateMixin {
  int _appointmentId = 0;

  List<Appointment> _presentAppointments = presentAppointments;
  List<Appointment> _pastAppointments = pastAppointments;

  String currentGif = 'registrarse_nuevo';
  String gifPath = '';
  GifController controller;

  bool selectedBtn = false;

  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightGrey,
      appBar: defaultAppBar('Atenciones', true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${_presentAppointments[_appointmentId].type} en ${_pastAppointments[0].place}',
            ),
            Text(
              '$_appointmentId',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_gifimage/flutter_gifimage.dart';
// import 'package:modal_progress_hud/modal_progress_hud.dart';

// import 'package:lsc_app/components/app_button.dart';
// import 'package:lsc_app/components/gif_and_btn_container.dart';
// import 'package:lsc_app/constants/constants.dart';
// import 'package:lsc_app/firebase/firebase_functions.dart';
// import 'package:lsc_app/helpers/default_appbar.dart';
// import 'package:lsc_app/main.dart';
// import 'package:lsc_app/screens/form_screen.dart';
// import 'package:lsc_app/validators/validation.dart';

// class RegistrationScreen extends StatefulWidget {
//   static const id = 'registration_screen';

//   @override
//   _RegistrationScreenState createState() => _RegistrationScreenState();
// }

// class _RegistrationScreenState extends State<RegistrationScreen>
//     with TickerProviderStateMixin {
//   String id;
//   String email;
//   String password1;
//   String password2;
//   String fullPassword;
//   String alertValue = '';
//   bool showSpinner = false;
//   bool isVisible = false;

//   String currentGif = 'registrarse_nuevo';
//   String gifPath = '';
//   GifController controller;

//   bool idEnabled = false;
//   bool passwordEnabled = false;
//   bool passwordConfirmEnabled = false;
//   bool selectedBtn = false;
//   FocusNode idFocusNode;
//   FocusNode passwordFocusNode;
//   FocusNode passwordConfirmFocusNode;

//   final _formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     controller = GifController(vsync: this);
//     idFocusNode = FocusNode();
//     passwordFocusNode = FocusNode();
//     passwordConfirmFocusNode = FocusNode();
//     playGif(currentGif);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     idFocusNode.dispose();
//     passwordFocusNode.dispose();
//     passwordConfirmFocusNode.dispose();
//     super.dispose();
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

//   registerFunction() async {
//     FocusScope.of(context).requestFocus(FocusNode());
//     setState(() {
//       idEnabled = true;
//       passwordEnabled = true;
//       passwordConfirmEnabled = true;
//     });
//     if (_formKey.currentState.validate()) {
//       setState(() {
//         showSpinner = true;
//       });
//       if (password1 == password2) {
//         email = '$id@ces.edu.co';
//         fullPassword = password1 + '00';

//         try {
//           FirebaseFunctions()
//               .firebaseCreateUserWithEmailAndPassword(email, fullPassword)
//               .then((_) {
//             Navigator.pushNamed(context, FormScreen.id);
//           }).catchError((e) {
//             Validator().firebaseRegisterValidationErrors(e, (errorText) {
//               setState(() {
//                 showSpinner = false;
//                 isVisible = true;
//                 alertValue = errorText;
//               });
//             });
//           });
//         } catch (e) {
//           Validator().firebaseRegisterValidationErrors(e, (errorText) {
//             setState(() {
//               showSpinner = false;
//               isVisible = true;
//               alertValue = errorText;
//             });
//           });
//         } finally {
//           setState(() {
//             showSpinner = false;
//           });
//         }
//       } else {
//         setState(() {
//           showSpinner = false;
//           isVisible = true;
//           alertValue = Validator().validateMatchingPasswords();
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;

//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: defaultAppBar('Nuevo Usuario', true),
//       backgroundColor: kBackgroundColor,
//       body: GestureDetector(
//         onTap: () {
//           FocusScopeNode currentFocus = FocusScope.of(context);
//           if (!currentFocus.hasPrimaryFocus &&
//               currentFocus.focusedChild != null) {
//             currentFocus.focusedChild.unfocus();
//           }
//           setState(() {
//             idEnabled = false;
//             passwordEnabled = false;
//             passwordConfirmEnabled = false;
//           });
//         },
//         child: ModalProgressHUD(
//           inAsyncCall: showSpinner,
//           child: SafeArea(
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: Center(
//                       child: Container(
//                         padding: EdgeInsets.symmetric(
//                             horizontal:
//                                 MediaQuery.of(context).size.width * 0.1),
//                         child: ListView(
//                           shrinkWrap: true,
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   idEnabled = true;
//                                   passwordEnabled = false;
//                                   passwordConfirmEnabled = false;
//                                   selectedBtn = false;
//                                 });
//                                 playGif('ingresar_documento');
//                               },
//                               child: TextFormField(
//                                 onTap: () {
//                                   playGif('ingresar_documento');
//                                 },
//                                 onEditingComplete: () {
//                                   setState(() {
//                                     idEnabled = false;
//                                   });
//                                 },
//                                 enabled: idEnabled,
//                                 focusNode: idFocusNode,
//                                 keyboardType: TextInputType.number,
//                                 inputFormatters: [
//                                   FilteringTextInputFormatter.digitsOnly,
//                                 ],
//                                 textAlign: TextAlign.center,
//                                 style: kTextFormFieldStyle,
//                                 onChanged: (value) {
//                                   id = value;
//                                 },
//                                 validator: (value) {
//                                   return Validator().validateIDField(value);
//                                 },
//                                 decoration: kTextFieldDecoration.copyWith(
//                                   hintText: 'Ingresa tu identificación',
//                                   hintStyle: kTextFormFieldStyle,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 15.0,
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   idEnabled = false;
//                                   passwordEnabled = true;
//                                   passwordConfirmEnabled = false;
//                                   selectedBtn = false;
//                                 });
//                                 playGif('ingresar_contrasena');
//                               },
//                               child: TextFormField(
//                                 onTap: () {
//                                   playGif('ingresar_contrasena');
//                                 },
//                                 onEditingComplete: () {
//                                   setState(() {
//                                     passwordEnabled = false;
//                                   });
//                                 },
//                                 enabled: passwordEnabled,
//                                 focusNode: passwordFocusNode,
//                                 keyboardType: TextInputType.number,
//                                 inputFormatters: [
//                                   FilteringTextInputFormatter.digitsOnly,
//                                 ],
//                                 textAlign: TextAlign.center,
//                                 obscureText: true,
//                                 style: kTextFormFieldStyle,
//                                 onChanged: (value) {
//                                   password1 = value;
//                                 },
//                                 validator: (value) {
//                                   return Validator()
//                                       .validatePasswordField(value);
//                                 },
//                                 decoration: kTextFieldDecoration.copyWith(
//                                   hintText: 'Ingresa tu contraseña',
//                                   hintStyle: kTextFormFieldStyle,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 5.0,
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   idEnabled = false;
//                                   passwordEnabled = false;
//                                   passwordConfirmEnabled = true;
//                                   selectedBtn = false;
//                                 });
//                                 playGif('confirmar_contrasena');
//                               },
//                               child: TextFormField(
//                                 onTap: () {
//                                   playGif('confirmar_contrasena');
//                                 },
//                                 onEditingComplete: () {
//                                   setState(() {
//                                     passwordConfirmEnabled = false;
//                                   });
//                                 },
//                                 enabled: passwordConfirmEnabled,
//                                 focusNode: passwordConfirmFocusNode,
//                                 keyboardType: TextInputType.number,
//                                 inputFormatters: [
//                                   FilteringTextInputFormatter.digitsOnly,
//                                 ],
//                                 textAlign: TextAlign.center,
//                                 obscureText: true,
//                                 style: kTextFormFieldStyle,
//                                 onChanged: (value) {
//                                   password2 = value;
//                                 },
//                                 validator: (value) {
//                                   return Validator()
//                                       .validatePasswordField(value);
//                                 },
//                                 decoration: kTextFieldDecoration.copyWith(
//                                   hintText: 'Confirma tu contraseña',
//                                   hintStyle: kTextFormFieldStyle,
//                                 ),
//                               ),
//                             ),
//                             Visibility(
//                               child: Container(
//                                 margin: EdgeInsets.only(top: 10.0),
//                                 child: Text(
//                                   alertValue,
//                                   style: TextStyle(
//                                     color: kErrorAlert,
//                                   ),
//                                 ),
//                               ),
//                               visible: isVisible,
//                             ),
//                             SizedBox(
//                               height: 25.0,
//                             ),
//                             AppButton(
//                               btnColor: kDarkBlue,
//                               btnBorderColor: selectedBtn
//                                   ? kActiveBtnColor
//                                   : Colors.transparent,
//                               title: 'Registrarme',
//                               textColor: Colors.white,
//                               onPress: () {
//                                 playGif('registrarse_nuevo');
//                                 setState(() {
//                                   idEnabled = false;
//                                   passwordEnabled = false;
//                                   passwordConfirmEnabled = false;
//                                   selectedBtn = true;
//                                 });
//                               },
//                               onDoublePress: registerFunction,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   GifAndBtnContainer(
//                     controller: controller,
//                     gif: gifPath,
//                     isVisible: !isKeyboardShowing,
//                     onTap: () {
//                       if (currentGif == 'ingresar_documento') {
//                         idFocusNode.requestFocus();
//                       } else if (currentGif == 'ingresar_contrasena') {
//                         passwordFocusNode.requestFocus();
//                       } else if (currentGif == 'confirmar_contrasena') {
//                         passwordConfirmFocusNode.requestFocus();
//                       } else if (currentGif == 'registrarse_nuevo') {
//                         registerFunction();
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
