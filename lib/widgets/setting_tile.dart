import 'package:flutter/material.dart';

class SettingTile extends StatelessWidget {

  final String text;
  final Widget control;
  final Function function;

  SettingTile({this.text, this.control, this.function});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(text),
        control,
      ],
    );
  }
}