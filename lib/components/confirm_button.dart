import 'package:flutter/material.dart';

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({
    @required this.color,
    @required this.gif,
    @required this.onPressed,
  });

  final Color color;
  final String gif;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 58.0,
      width: 58.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(40.0),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(3, 3),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(
          Icons.check,
          color: Colors.white,
          size: 28,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
