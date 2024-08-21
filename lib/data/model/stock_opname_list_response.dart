// import 'package:json_annotation/json_annotation.dart';

// part 'stock_opname_list_response.g.dart';

// @JsonSerializable(fieldRename: FieldRename.snake)
// class StockOpnameGetList {
//   int? status;
//   String? message;
//   List<DataGet>? data;

//   StockOpnameGetList({this.status, this.message, this.data});

//   StockOpnameGetList.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <DataGet>[];
//       json['data'].forEach((v) {
//         data!.add(new DataGet.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class DataGet {
//   String? pos;
//   String? lokasi;
//   String? tanggal;

//   DataGet({this.pos, this.lokasi, this.tanggal});

//   DataGet.fromJson(Map<String, dynamic> json) {
//     pos = json['pos'];
//     lokasi = json['lokasi'];
//     tanggal = json['tanggal'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['pos'] = this.pos;
//     data['lokasi'] = this.lokasi;
//     data['tanggal'] = this.tanggal;
//     return data;
//   }
// }
