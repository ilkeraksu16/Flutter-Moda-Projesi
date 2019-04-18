class Kiyafet{
  int id;
  String resimBase64;
  String bolum;
  String mevsim;
  String tarz;

  Kiyafet({this.resimBase64,this.bolum,this.mevsim,this.tarz});

  Map<String, dynamic> toMap(){
    var map =Map<String, dynamic>();

    map['id'] =id;
    map['resimBase64'] =resimBase64;
    map['bolum'] =bolum;
    map['mevsim'] =mevsim;
    map['tarz'] =tarz;

    return map;
  }

  Kiyafet.fromMap(Map<String, dynamic> map){
    id =map['id'];
    resimBase64 =map['resimBase64'];
    bolum =map['bolum'];
    mevsim =map['mevsim'];
    tarz =map['tarz'];
  }
}