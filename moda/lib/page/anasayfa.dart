import 'package:flutter/material.dart';
import 'package:flip_box_bar/flip_box_bar.dart';
import 'package:moda/page/add_kombin.dart';
import 'package:moda/page/create_kombin.dart';
import 'package:moda/page/old_kombin.dart';
import 'package:flutter/cupertino.dart';
import 'package:moda/page/list_kombin.dart';



class Anasayfa extends StatefulWidget {
  @override
  _AnasayfaState createState() => _AnasayfaState();
}



class _AnasayfaState extends State<Anasayfa> {
  Color navRenk;
  int _currentIndex = 0;

  final List<Color> renk =[
    Colors.orangeAccent,
    Colors.purpleAccent,
    Colors.pinkAccent
  ];
  
  final List<Widget> _children = [
    CreateKombin(),
    OldKombin(),
    AddKombin(),
  ];
  
  @override
  void initState() {
    navRenk =renk[0];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text('Modacım'),
        backgroundColor: navRenk,
        actions: <Widget>[
          IconButton(
            onPressed: (){
              Navigator.of(context).push(CupertinoPageRoute(
                builder: (context) => ListKombin()
              ));
            },
            icon: Icon(Icons.list),
          )
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: FlipBoxBar(
          items: [
            FlipBarItem(icon: Icon(Icons.assignment_ind,color: Colors.white,), text: Text("Kombin Oluştur",style: TextStyle(color: Colors.white)), frontColor: Colors.orange, backColor: Colors.orangeAccent),
            FlipBarItem(icon: Icon(Icons.date_range,color: Colors.white,), text: Text("Giydiklerim",style: TextStyle(color: Colors.white),), frontColor: Colors.purple, backColor: Colors.purpleAccent),
            FlipBarItem(icon: Icon(Icons.add_circle_outline,color: Colors.white,), text: Text("Elbise Ekle",style: TextStyle(color: Colors.white)), frontColor: Colors.pink, backColor: Colors.pinkAccent),
          ],

          animationDuration: Duration(milliseconds: 700),
          navBarHeight: 80.0,
          onIndexChanged: (newIndex) {
            setState(() {
              navRenk =renk[newIndex];
             _currentIndex = newIndex; 
            });
          },
        ),
    );
  }
}