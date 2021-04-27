import 'package:flutter/material.dart';
import 'package:atenciones_v2/constants/constants.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    @required this.btnColor,
    @required this.btnBorderColor,
    @required this.title,
    @required this.textColor,
    @required this.onPress,
    @required this.onDoublePress,
  });

  final Color btnColor;
  final Color btnBorderColor;
  final String title;
  final Color textColor;
  final Function onPress;
  final Function onDoublePress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      onDoubleTap: onDoublePress,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: kGrey.withOpacity(0.5), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: btnBorderColor,
              spreadRadius: 3,
              blurRadius: 1,
              offset: Offset(0, 0),
            ),
          ],
        ),
        height: 50.0,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontSize: 20.0,
            letterSpacing: 1,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
