class AppointmentType {
  final String type;
  final String name;

  AppointmentType({
    this.type,
    this.name,
  });

  String image(String t) {
    return t + '.jpg';
  }
}
