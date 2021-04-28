import 'package:atenciones_v2/constants/constants.dart';
import 'package:atenciones_v2/screens/individual_appointment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

// import 'package:atenciones_v2/screens/health_appointments_main.dart';
// import 'package:atenciones_v2/screens/individual_appointment.dart';
import 'package:atenciones_v2/models/appointment.dart';
import 'package:atenciones_v2/models/appointment_type.dart';

class AppointmentList extends StatefulWidget {
  final Function deleteAppointment;
  final Function playGif;
  final List<Appointment> renderList;
  final Function viewAppointment;

  AppointmentList(
    this.deleteAppointment,
    this.playGif,
    this.renderList,
    this.viewAppointment,
  );

  @override
  _AppointmentListState createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
          vertical: 3,
          horizontal: 8,
        ),
        height: MediaQuery.of(context).size.height * 0.43,
        child: widget.renderList.isEmpty
            ? NoAppointmentsYet()
            : appointmentChips());
  }

  int _selectedChip = 0;

  Widget appointmentChips() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.all(3),
          child: GestureDetector(
            child: ChoiceChip(
              avatar: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage(
                    'images/${AppointmentType().image(widget.renderList[index].type)}'),
              ),
              label: Padding(
                padding: const EdgeInsets.all(1),
                child: ListTile(
                  minVerticalPadding: 5,
                  title: Text(
                    DateFormat.yMd().format(widget.renderList[index].date),
                  ),
                  subtitle: Text(
                    '${appointmentName(widget.renderList[index].type)} en ${widget.renderList[index].place} \nHora: ${(widget.renderList[index].time).format(context)}',
                  ),
                ),
              ),
              backgroundColor: Colors.white,
              selected: _selectedChip == widget.renderList[index].id,
              shape: StadiumBorder(
                  side: _selectedChip == widget.renderList[index].id
                      ? BorderSide(color: kLightBlue, width: 3)
                      : BorderSide.none),
              onSelected: (selected) {
                setState(() {
                  _selectedChip = widget.renderList[index].id;
                });
                widget.playGif(widget.renderList[index].type);
                widget.viewAppointment(widget.renderList[index]);
              },
              selectedColor: Colors.transparent,
            ),
            onDoubleTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => IndividualAppointment(
                    appointment: widget.renderList[index]),
              ),
            ),
          ),
        );
      },
      itemCount: widget.renderList.length,
    );
  }
}

class NoAppointmentsYet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Image.asset(
              "images/sin_citas.png",
              fit: BoxFit.scaleDown,
            ),
          ),
        ],
      ),
    );
  }
}
