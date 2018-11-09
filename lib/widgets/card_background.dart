 import 'package:flutter/material.dart';

class CardBackground extends StatelessWidget {

    final Color color;

    CardBackground({this.color});

    @override
    Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(6.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 6.0,
            height: 70.0,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5.0),
                    bottomLeft: Radius.circular(5.0)),
              ),
            ),
          ),
        ],
      ),
    );
  } }