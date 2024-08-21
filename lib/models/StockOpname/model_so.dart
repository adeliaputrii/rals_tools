class StockOpnameModel{
  int? id;
  String? sku;
  String? qty;
  
  StockOpnameModel({
    this.id,
    this.sku,
    this.qty,
  });

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['sku'] = sku;
    map['quantity'] = qty;
    return map;
  }

  StockOpnameModel.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.sku = map['sku'];
    this.qty= map['quantity'];
  }
  static List<StockOpnameModel> stockOpname = [];
}