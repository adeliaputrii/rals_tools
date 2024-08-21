import 'dart:convert';

class SoSaveDataModel {
  int? id;
  String? pos;
  String? location;
  String? tanggal;
  List<ItemData>? data;  // Add this to hold the list of items

  SoSaveDataModel({
    this.id,
    this.pos,
    this.location,
    this.tanggal,
    this.data,
  });

  // Convert the model to a map
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    map['pos'] = pos;
    map['location'] = location;
    map['tanggal'] = tanggal;
    if (data != null) {
      map['data'] = jsonEncode(data!.map((item) => item.toMap()).toList()); // Convert list to JSON string
    }
    return map;
  }

  // Create a model from a map
  SoSaveDataModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    pos = map['pos'];
    location = map['location'];
    tanggal = map['tanggal'];
    if (map['data'] != null) {
      data = (jsonDecode(map['data']) as List)
          .map((item) => ItemData.fromMap(item))
          .toList(); // Convert JSON string back to list
    }
  }
}

// ItemData class to hold the data items
class ItemData {
  String? sku;
  String? qty;

  ItemData({
    this.sku,
    this.qty,
  });

  // Convert the item to a map
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['sku'] = sku;
    map['quantity'] = qty;
    return map;
  }

  // Create an item from a map
  ItemData.fromMap(Map<String, dynamic> map) {
    sku = map['sku'];
    qty = map['quantity'];
  }
}
