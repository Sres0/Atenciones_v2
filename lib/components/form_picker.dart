import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:atenciones_v2/constants/constants.dart';
import 'package:atenciones_v2/validators/validation.dart';

class FormPicker extends StatefulWidget {
  FormPicker({
    @required this.selectedItem,
    @required this.hintTxt,
    @required this.itemsList,
    @required this.textController,
    @required this.pickerFocusNode,
    @required this.isEnabled,
    this.isMandatory = true,
    @required this.disablePicker,
  });

  final String selectedItem;
  final String hintTxt;
  final List<String> itemsList;
  final TextEditingController textController;
  final FocusNode pickerFocusNode;
  final bool isEnabled;
  final bool isMandatory;
  final Function disablePicker;

  @override
  _FormPickerState createState() => _FormPickerState();
}

class _FormPickerState extends State<FormPicker> {
  TextEditingController textController;
  String selectedItem;
  String hintTxt;
  List<String> itemsList;
  FocusNode pickerFocusNode;
  bool isEnabled;
  bool isMandatory;
  Function disablePicker;

  @override
  void initState() {
    selectedItem = widget.selectedItem;
    hintTxt = widget.hintTxt;
    itemsList = widget.itemsList;
    textController = widget.textController;
    isMandatory = widget.isMandatory;
    disablePicker = widget.disablePicker;

    super.initState();
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String item in itemsList) {
      pickerItems.add(Text(item));
    }

    return CupertinoPicker(
      itemExtent: 50.0,
      backgroundColor: Colors.white,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedItem = itemsList[selectedIndex];
          textController.value = TextEditingValue(
            text: selectedItem,
          );
        });
      },
      children: pickerItems,
    );
  }

  String validateFunction(value) {
    if (value == null) {
      value = '';
    }
    if (isMandatory) {
      return Validator().validateTextField(value);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    pickerFocusNode = widget.pickerFocusNode;
    isEnabled = widget.isEnabled;
    itemsList = widget.itemsList;

    return Platform.isIOS
        ? TextFormField(
            onTap: () {
              pickerFocusNode.unfocus();
              disablePicker();
              showModalBottomSheet(
                context: context,
                builder: (BuildContext builder) {
                  return Container(
                    child: iOSPicker(),
                    height: MediaQuery.of(context).copyWith().size.height / 3,
                  );
                },
              );
            },
            enabled: isEnabled,
            focusNode: pickerFocusNode,
            readOnly: true,
            style: kTextFormFieldStyle,
            controller: textController,
            textAlign: TextAlign.center,
            decoration: kTextFieldDecoration.copyWith(
              hintText: hintTxt,
              hintStyle: kTextFormFieldStyle,
            ),
            validator: (value) => validateFunction(value),
          )
        : Center(
            child: DropdownButtonFormField(
              isExpanded: true,
              isDense: true,
              focusNode: pickerFocusNode,
              onTap: () {
                pickerFocusNode.requestFocus();
              },
              decoration: isEnabled
                  ? kDropdownButtonFormFieldDecoration.copyWith(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kDarkBlue, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    )
                  : kDropdownButtonFormFieldDecoration,
              hint: Center(
                child: Text(
                  hintTxt,
                  textAlign: TextAlign.center,
                ),
              ),
              onChanged: isEnabled
                  ? (String newValue) {
                      setState(() {
                        selectedItem = newValue;
                        textController.value = TextEditingValue(
                          text: selectedItem,
                        );
                      });
                    }
                  : null,
              items: itemsList.map((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Center(
                    child: Text(
                      value,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }).toList(),
              validator: (value) => validateFunction(value),
            ),
          );
  }
}
