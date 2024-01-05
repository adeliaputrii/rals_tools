class VoidOffline{
  int? id_act;
  String? idGenerate;
  String? date;
  
  VoidOffline({
    this.id_act,
    this.idGenerate,
    this.date,
  });

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id_act != null) {
      map['id_act'] = id_act;
    }
    map['idGenerate'] = idGenerate;
    map['date'] = date;
    return map;
  }

  VoidOffline.fromMap(Map<String, dynamic> map) {
    this.id_act = map['id_act'];
    this.idGenerate = map['idGenerate'];
    this.date = map['date'];
  }
  static List<VoidOffline> voidOffline = [];
}