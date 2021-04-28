import 'package:atenciones_v2/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// import 'package:atenciones_v2/screens/health_appointments_main.dart';
import 'package:atenciones_v2/models/appointment.dart';
import 'package:atenciones_v2/models/appointment_type.dart';

class AppointmentList extends StatefulWidget {
  final Function deleteAppointment;
  final Function playGif;
  final Function proceed;
  final List<Appointment> renderList;

  AppointmentList(
    this.deleteAppointment,
    this.playGif,
    this.renderList,
    this.proceed,
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
                _selectedChip = selected ? widget.renderList[index].id : null;
                widget.playGif(widget.renderList[index].type.toString());
              });
            },
            selectedColor: Colors.transparent,
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
