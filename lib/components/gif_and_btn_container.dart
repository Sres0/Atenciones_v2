import 'package:flutter/material.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';

import 'package:atenciones_v2/components/confirm_button.dart';
import 'package:atenciones_v2/constants/constants.dart';

class GifAndBtnContainer extends StatelessWidget {
  const GifAndBtnContainer({
    @required this.controller,
    @required this.gif,
    @required this.isVisible,
    @required this.onTap,
  });

  final GifController controller;
  final String gif;
  final bool isVisible;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.24,
        padding: EdgeInsets.all(7.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Card(
              child: GifImage(
                controller: controller,
                image: AssetImage('images/$gif'),
              ),
              elevation: 7,
            ),
            ConfirmButton(
              color: kDarkBlue,
              gif: gif,
              onPressed: onTap,
            ),
          ],
        ),
      ),
    );
  }
}
