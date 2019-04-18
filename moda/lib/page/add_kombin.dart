import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moda/model/kiyafet.dart';
import 'package:moda/database/db_helper.dart';

class AddKombin extends StatefulWidget {
  @override
  _AddKombinState createState() => _AddKombinState();
}

class _AddKombinState extends State<AddKombin> {

  File _pickedImage;
  bool isImageLoaded = false;
  DbHelper _dbHelper;
  Kiyafet kiyafet;

  static List<String> _kisim = ["Üst Kısım","Alt Kısım","Ayakkabı"];
  static List<String> _mevsimlik = ["Yazlık","Kışlık","Baharlık"];
  static List<String> _tarzlik = ["Spor","Günlük","Özel"];

  String _hangiBolum;
  String _hangiMevsim;
  String _hangiTarz;

  Future pickImageC() async{
    var tempStore = await ImagePicker.pickImage(source: ImageSource.camera);
    if(tempStore != null){
      setState(() {
        _pickedImage =tempStore;
        isImageLoaded = true;
      });
    }
  }

  Future pickImageG() async {
    var tempStore = await ImagePicker.pickImage(source: ImageSource.gallery);
    if(tempStore != null){
      setState(() {
        _pickedImage =tempStore;
        isImageLoaded = true; 
      });
    }
  }
  
  @override
  void initState() {
    //setState(() {
    _hangiBolum =_kisim[0];
    _hangiMevsim =_mevsimlik[0];
    _hangiTarz =_tarzlik[0];  
    //});
    _dbHelper =DbHelper();
    super.initState();
  }
  
  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _navbar(),
          SizedBox(height: 10.0,),
          isImageLoaded ? _resimGoster() : _resimDefault(),
          SizedBox(height: 10.0,),
          Padding(
            padding: EdgeInsets.only(left: 10.0,right: 10.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _btnKameraAc(),
                    SizedBox(width: 10.0,),
                    _btnGaleriAc(),
                  ],
                ),
                SizedBox(height: 15.0,),
                _line(),
                SizedBox(height: 5.0,),
                _dropListBolum('Elbise Hangi Bölüm', _kisim),
                SizedBox(height: 5.0,),
                _line(),
                SizedBox(height: 5.0,),
                _dropListMevsim('Elbise Hangi Mevsim',_mevsimlik),
                SizedBox(height: 5.0,),
                _line(),
                SizedBox(height: 5.0,),
                _dropListTarz('Elbise Hangi Tarz',_tarzlik),
                SizedBox(height: 5.0,),
                _line(),
                SizedBox(height: 5.0,),
                //_line(),
                isImageLoaded ? _btnKaydet() :Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _navbar(){
    return Padding(
      padding: EdgeInsets.only(left: 15.0,right: 15.0),
      child: Container(
        height: 30.0,
        decoration: BoxDecoration(
          color: Colors.pinkAccent,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0)),
        ),
        child: Center(child: Text('Elbise Ekle',style: TextStyle(color: Colors.white,fontSize: 18.0),)),
      ),
    );
  }

  Widget _resimGoster(){
    return Center(
      child: Container(
        height: 150.0,
        width: 150.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          image: DecorationImage(
            image: FileImage(_pickedImage,),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 2.0,
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _resimDefault(){
    return Container(
      height: 150.0,
      width: 150.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        //border: Border.all(color: Colors.grey),
        boxShadow: [
          BoxShadow(
            blurRadius: 2.0,
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Icon(Icons.image,size: 25.0,),
          ),
          SizedBox(
            height: 15.0,
          ),
          Center(
            child: Text('Resim Seçilmedi',style: TextStyle(color:Colors.red),),
          )
        ],
      )
    );
  }

  Widget _btnKameraAc(){
    return Expanded(
      child: RaisedButton(
        color: Color(0XFFFDF0F0),
        child: Text('Kamerayı Aç'),
        onPressed: pickImageC,
      ),
    );
  }

  Widget _btnGaleriAc(){
    return Expanded(
      child: RaisedButton(
        color: Color(0XFFFDF0F0),
        child: Text('Galeriden Seç'),
        onPressed: pickImageG,
      ),
    );
  }

  Widget _btnKaydet(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            
            child: RaisedButton(
              color: Colors.pink,
              child: Padding(
                padding: const EdgeInsets.only(top:5.0, bottom: 5.0),
                child: Text('Kaydet',style: TextStyle(fontSize: 18.0,color: Colors.white),),
              ),
              onPressed: ()async{
                //List<int> imageBytes = pickedImage.readAsBytesSync();
                await ekle(context);
                setState(() {
                  
                });
              //print(imageBytes);
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),side: BorderSide(color: Colors.white)),
              
            ),
          )
        ],
      ),
    );
  }

  Widget _line(){
    return Container(
      color: Colors.blueGrey[100],
      width: MediaQuery.of(context).size.width,
      height: 1.0,
    );
  }

  Widget _dropListBolum(String _title, List<String> _values){
    return ListTile(
      title: Text(_title),
      trailing: DropdownButton(
        items: _values.map((String ogeler){
          return DropdownMenuItem<String>(
            value: ogeler,
            child: Text(ogeler),
          );
        }).toList(),
        value: _hangiBolum,//veritabanından çekilecek
        onChanged: (value){
          setState(() {
            _hangiBolum = value;
            //print('$_hangiBolum');
          });
        },
      ),
    );
  }

  Widget _dropListMevsim(String _title, List<String> _values){
    return ListTile(
      title: Text(_title),
      trailing: DropdownButton(
        items: _values.map((String ogeler){
          return DropdownMenuItem<String>(
            value: ogeler,
            child: Text(ogeler),
          );
        }).toList(),
        value: _hangiMevsim,//veritabanından çekilecek
        onChanged: (value){
          setState(() {
            _hangiMevsim = value;
            //print('$_hangiMevsim');
          });
        },
      ),
    );
  }

  Widget _dropListTarz(String _title, List<String> _values){
    return ListTile(
      title: Text(_title),
      trailing: DropdownButton(
        items: _values.map((String ogeler){
          return DropdownMenuItem<String>(
            value: ogeler,
            child: Text(ogeler),
          );
        }).toList(),
        value: _hangiTarz,//veritabanından çekilecek
        onChanged: (value){
          setState(() {
            _hangiTarz = value;
            //print('$_hangiTarz');
          });
        },
      ),
    );
  }

  Future<void> ekle(BuildContext context)async{
    
    int result;
    kiyafet =Kiyafet(resimBase64: _pickedImage.path,bolum: _hangiBolum,mevsim: _hangiMevsim,tarz: _hangiTarz);
    result=await _dbHelper.insertKiyafet(kiyafet);

    if(result != null)
    {
      mesaj(context,'Kayıt Başarılı');
    }
    else{
      mesaj(context,'Hata Oluştu');
    }
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> mesaj(BuildContext context,String mesaj){
    return Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(mesaj,style: TextStyle(color: Colors.black),),
        duration: Duration(milliseconds: 1500),
        backgroundColor: Colors.white,
      ),
    );
  }
}