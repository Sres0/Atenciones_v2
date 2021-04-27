import 'package:flutter/services.dart';

class Validator {
  String validateIDField(value) {
    if (value.isEmpty) {
      return 'Este campo es obligatorio.';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'No use números.';
    }
    if (value.length < 4) {
      return 'El valor debe contener al menos 4 numeros.';
    } else if (value.length > 12) {
      return 'El valor no debe contener mas de 12 numeros.';
    }
    return null;
  }

  String validateEmailField(value) {
    if (!value.isEmpty && !value.contains('@')) {
      return 'Su correo electrónico debe contener un @.';
    }
    return null;
  }

  String validatePasswordField(value) {
    if (value.isEmpty) {
      return 'Este campo es obligatorio.';
    }
    if (value.length != 4) {
      return 'Su contraseña debe tener 4 caracteres.';
    }
    return null;
  }

  void firebaseLoginValidationErrors(e, Function updateState) {
    String errorText = '';
    if (e is PlatformException) {
      if (e.code == 'ERROR_WRONG_PASSWORD') {
        errorText = 'La contraseña es inválida.';
      } else if (e.code == 'ERROR_USER_NOT_FOUND') {
        errorText = 'No se encontró identificación.';
      } else if (e.code == 'ERROR_TOO_MANY_REQUESTS') {
        errorText =
            'Demasiados intentos de inicio de sesión fallidos. Por favor, inténtelo de nuevo más tarde.';
      }
    } else {
      if (e.code == 'invalid-email') {
        errorText = 'Identificación inválida.';
      } else if (e.code == 'user-disabled') {
        errorText = 'Usuario deshabilitado.';
      } else if (e.code == 'user-not-found') {
        errorText = 'Usuario no encontrado.';
      } else if (e.code == 'wrong-password') {
        errorText = 'Contraseña incorrecta.';
      }
    }
    updateState(errorText);
  }

  void firebaseRegisterValidationErrors(e, Function updateState) {
    String errorText = '';
    if (e is PlatformException) {
      if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        errorText = 'Id ya en uso.';
      } else if (e.code == 'ERROR_INVALID_EMAIL') {
        errorText = 'Id inválido.';
      }
    } else {
      if (e.code == 'email-already-in-use') {
        errorText = 'Id ya en uso.';
      } else if (e.code == 'invalid-email') {
        errorText = 'Id inválido.';
      } else if (e.code == 'operation-not-allowed') {
        errorText = 'Operación no permitida.';
      } else if (e.code == 'weak-password') {
        errorText = 'Contraseña débil.';
      }
    }
    updateState(errorText);
  }

  String validateMatchingPasswords() {
    return 'Las contraseñas no coinciden.';
  }

  String validateTextField(String value) {
    if (value.isEmpty || value == '') {
      return 'Este campo es obligatorio.';
    }
    if (value.contains('@')) {
      return 'No use @.';
    }
    if (value.contains(RegExp(r'[0-9]'))) {
      return 'No use números.';
    }
    return null;
  }

  String validateMobilePhoneField(String value) {
    if (value.isEmpty) {
      return 'Este campo es obligatorio.';
    }
    if (value.contains('@')) {
      return 'No use @.';
    }
    if (value.length != 10) {
      return 'Ingresa un numero de célular válido.';
    }
    return null;
  }

  String validateDatePicker(value) {
    if (value.isEmpty) {
      return 'Este campo es obligatorio.';
    }
    return null;
  }

  String validateEPSField(value) {
    if (!value.isEmpty && value.contains('@')) {
      return 'No use @.';
    }
    if (value.contains(RegExp(r'[0-9]'))) {
      return 'No use números.';
    }
    return null;
  }
}
