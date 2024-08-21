class LogOffline{
  int? id_act;
  String? deskripsi;
  String? datetime;
  
  LogOffline({
    this.id_act,
    this.deskripsi,
    this.datetime,
  });

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id_act != null) {
      map['id_act'] = id_act;
    }
    map['deskripsi'] = deskripsi;
    map['datetime'] = datetime;
    return map;
  }

  LogOffline.fromMap(Map<String, dynamic> map) {
    this.id_act = map['id_act'];
    this.deskripsi = map['deskripsi'];
    this.datetime = map['datetime'];
  }
  static List<LogOffline> listActivity = [];
}