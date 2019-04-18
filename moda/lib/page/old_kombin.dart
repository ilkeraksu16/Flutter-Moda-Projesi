import 'package:flutter/material.dart';

class OldKombin extends StatefulWidget {
  @override
  _OldKombinState createState() => _OldKombinState();
}

class _OldKombinState extends State<OldKombin> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 15.0,right: 15.0),
          child: Container(
            height: 30.0,
            decoration: BoxDecoration(
              color: Colors.purpleAccent,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0)),
            ),
            child: Center(child: Text('Giydiklerim',style: TextStyle(color: Colors.white,fontSize: 18.0),)),
          ),
        ),
      ],
    );
  }
}