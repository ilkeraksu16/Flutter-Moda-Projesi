import 'package:flutter/material.dart';

class CreateKombin extends StatefulWidget {
  @override
  _CreateKombinState createState() => _CreateKombinState();
}

class _CreateKombinState extends State<CreateKombin> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 15.0,right: 15.0),
          child: Container(
            height: 30.0,
            decoration: BoxDecoration(
              color: Colors.orangeAccent,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0)),
            ),
            child: Center(child: Text('Kombin Oluştur',style: TextStyle(color: Colors.white,fontSize: 18.0),)),
          ),
        ),
        SizedBox(height: 15.0,),
        Center(
          child: Container(
            width: 80.0,
            height: 80.0,
            child: RaisedButton(
              onPressed: (){},
              child: Center(child: Text('Getir',style: TextStyle(color: Colors.white),)),
              color: Colors.redAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
            ),
          ),
        ),
        Card(
          
        )
      ],
    );
  }
}