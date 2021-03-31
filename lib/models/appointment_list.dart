import 'package:atenciones_v2/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// import 'package:atenciones_v2/screens/health_appointments_main.dart';
import 'package:atenciones_v2/models/appointment.dart';
import 'package:atenciones_v2/models/appointment_type.dart';

class AppointmentList extends StatefulWidget {
  final Function deleteAppointment;
  final Function playGif;

  final List<Appointment> renderList;

  AppointmentList(
    this.deleteAppointment,
    this.playGif,
    this.renderList,
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
          : ListView.builder(
              shrinkWrap: true,
              itemBuilder: (ctx, index) {
                return AppointmentCard(
                  index,
                  widget.deleteAppointment,
                  widget.playGif,
                  widget.renderList,
                );
              },
              itemCount: widget.renderList.length,
            ),
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

class AppointmentCard extends StatefulWidget {
  final int index;

  final Function deleteAppointment;
  final Function playGif;

  final List<Appointment> renderList;

  AppointmentCard(
    this.index,
    this.deleteAppointment,
    this.playGif,
    this.renderList,
  );

  @override
  _AppointmentCardState createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  bool selectedCard = false;
  bool selectedIcon = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(
          () {
            selectedCard = !selectedCard; //???? Quitarlo en otros
          },
        );
        widget.playGif(widget.renderList[widget.index].type);
      },
      onDoubleTap: () {},
      child: Card(
        shadowColor: selectedCard ? kActiveBtnColor : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        elevation: 7,
        margin: EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 3,
        ),
        child: ListTile(
          minVerticalPadding: 10,
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey,
            backgroundImage: AssetImage(
                'images/${AppointmentType().image(widget.renderList[widget.index].type)}'),
          ),
          title: Text(
            DateFormat.yMd().format(widget.renderList[widget.index].date),
          ),
          subtitle: Text(
            '${appointmentName(widget.renderList[widget.index].type)} en ${widget.renderList[widget.index].place}\nHora: ${(widget.renderList[widget.index].time).format(context)}',
          ),
          trailing: GestureDetector(
            child: IconButton(
              icon: Icon(
                Icons.delete,
                color: selectedIcon ? kDarkBlue : kLightGrey,
              ),
              onPressed: () {
                setState(
                  () {
                    // selectedIcon = true; //???
                    selectedIcon = !selectedIcon; //???
                  },
                );
                widget.playGif('borrar_cita');
              },
            ),
            onDoubleTap: () =>
                widget.deleteAppointment(widget.renderList[widget.index].id),
          ),
        ),
      ),
    );
  }
}
