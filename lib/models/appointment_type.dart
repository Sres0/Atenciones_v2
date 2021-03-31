class AppointmentType {
  final String type;

  AppointmentType({
    this.type,
  });

  String image(String t) {
    return t + '.jpg';
  }
}
