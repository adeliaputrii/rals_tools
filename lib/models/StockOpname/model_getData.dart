class SoGetDataModel{
  int? id;
  String? pos;
  String? location;
  String? tanggal;
  
  SoGetDataModel({
    this.id,
    this.pos,
    this.location,
    this.tanggal
  });

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['pos'] = pos;
    map['location'] = location;
    map['tanggal'] = tanggal;
    return map;
  }

  SoGetDataModel.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.pos= map['pos'];
    this.location= map['location'];
    this.tanggal= map['tanggal'];
  }
  static List<SoGetDataModel> soGetData = [];
}