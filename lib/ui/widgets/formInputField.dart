import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final Function validationHandler;
  final Function onSaveHandler;
  final String hintText;
  final bool hideText;
  final String initText;
  const InputField(
      {this.validationHandler,
      this.onSaveHandler,
      this.hintText,
      this.hideText = false,
      this.initText = ''});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validationHandler,
      onSaved: onSaveHandler,
      obscureText: hideText,
      initialValue: initText,
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: hintText,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
  }
}
