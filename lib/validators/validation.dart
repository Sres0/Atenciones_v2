class Validator {
  String validateDatePicker(value) {
    if (value.isEmpty) {
      return 'Este campo es obligatorio.';
    }
    return null;
  }
}
