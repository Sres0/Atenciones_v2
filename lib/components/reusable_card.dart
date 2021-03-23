import 'package:flutter/material.dart';
import 'package:atenciones_v2/constants/constants.dart';

class IconContent extends StatelessWidget {
  IconContent({@required this.icon, @required this.iconText});

  final IconData icon;
  final String iconText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            size: 70.0,
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            iconText,
            style: kLabelTextStyle,
          ),
        ],
      ),
    );
  }
}
