import 'dart:io';
import 'package:flutter/material.dart';
import 'package:moda/database/db_helper.dart';
import 'package:moda/model/kiyafet.dart';

class ListKombin extends StatefulWidget {
  @override
  _ListKombinState createState() => _ListKombinState();
}

class _ListKombinState extends State<ListKombin> {
  DbHelper _dbHelper;
  File tempStore ;
  int adet;

  @override
  void initState(){
    _dbHelper = DbHelper();
    adet = 0;
    getAdet();
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kıyafet Listem'),
        actions: <Widget>[
          textAdet()
        ],
      ),
      body: Container(
        color: Colors.blue,
        child: FutureBuilder(
          future: _dbHelper.getKiyafet(),
          builder: (BuildContext context, AsyncSnapshot<List<Kiyafet>> veri){
            
            if(!veri.hasData) return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),));
            if(veri.data.isEmpty) return Center( child:Text("Kıyafetin Şuanlık Yok",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),);
            
            List<Kiyafet> kiyafet = veri.data;
            return ListView.builder(
              itemCount: kiyafet.length,
              itemBuilder: (BuildContext context, int index){
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white
                    ),
                    padding: EdgeInsets.only(top:5.0,bottom: 5.0),
                    width: MediaQuery.of(context).size.width,
                    height: 80.0,
                    child: kiyafetShow(context, kiyafet[index]),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget kiyafetShow(BuildContext context, Kiyafet kiyafet){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.edit,color: Colors.green,),
            onPressed: (){},
          ),
        getShortImage(context, kiyafet.resimBase64),
        kiyafetKisimlariText(kiyafet),
        IconButton(
          icon: Icon(Icons.delete,color: Colors.red,),
          onPressed: () async{
            setState(() {});
            int cevap =await _dbHelper.deleteKiyafet(kiyafet.id);
            if(cevap ==1)
            {
              mesaj(context, 'Kıyafet Silindi');
            }
          },
        ),
      ],
    );
  }

  Widget kiyafetKisimlariText(Kiyafet kiyafet){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text('${kiyafet.bolum}',style: TextStyle(fontSize: 19.0,color: Colors.black),),
        Text('${kiyafet.mevsim}',style: TextStyle(fontSize: 17.0,color: Colors.black54),),
        Text('${kiyafet.tarz}',style: TextStyle(fontSize: 15.0,color: Colors.black38),),
      ],
    );
  } 

  Widget getShortImage(BuildContext context, String path){
    return GestureDetector(
      child: Image.asset(path,height: 70.0,width: 70.0,fit: BoxFit.cover,),
        onTap: ()async{
          await getLongImage(context,path);
        },
    );
  }
  Future getLongImage(BuildContext context, String path){
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          content:Image.asset(path,height: 300.0,)
        );
      }
    );
  }

  Widget textAdet(){
    return Center(child: Padding(
      padding: const EdgeInsets.only(right:8.0),
      child: Text('$adet Kıyafetin var'),
    ));
  }

  void getAdet()async{
    int a = await _dbHelper.kiyafetCount();
    setState(() {
      adet = a;
    });
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