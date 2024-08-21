import 'package:json_annotation/json_annotation.dart';

part 'stock_opname_submit_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)

class StockOpnameSubmitBody {
  String? quenic;
  List<StockOpnameBody>? data;

  StockOpnameSubmitBody({this.quenic, this.data});

  StockOpnameSubmitBody.fromJson(Map<String, dynamic> json) {
    quenic = json['quenic'];
    if (json['data'] != null) {
      data = <StockOpnameBody>[];
      json['data'].forEach((v) {
        data!.add(new StockOpnameBody.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quenic'] = this.quenic;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StockOpnameBody {
  String? pos;
  String? lokasi;
  String? tanggal;
  List<Data>? data;

  StockOpnameBody({this.pos, this.lokasi, this.tanggal, this.data});

  StockOpnameBody.fromJson(Map<String, dynamic> json) {
    pos = json['pos'];
    lokasi = json['lokasi'];
    tanggal = json['tanggal'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pos'] = this.pos;
    data['lokasi'] = this.lokasi;
    data['tanggal'] = this.tanggal;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sku;
  String? qty;

  Data({this.sku, this.qty});

  Data.fromJson(Map<String, dynamic> json) {
    sku = json['sku'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sku'] = this.sku;
    data['qty'] = this.qty;
    return data;
  }
}