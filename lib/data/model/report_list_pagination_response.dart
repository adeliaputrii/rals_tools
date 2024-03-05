import 'package:json_annotation/json_annotation.dart';

part 'report_list_pagination_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ReportListPaginationResponse {
  List<Data>? data;
  String? path;
  int? perPage;
  String? nextPageUrl;
  String? prevPageUrl;

  ReportListPaginationResponse({this.data, this.path, this.perPage, this.nextPageUrl, this.prevPageUrl});

  ReportListPaginationResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    path = json['path'];
    perPage = json['per_page'];
    nextPageUrl = json['next_page_url'];
    prevPageUrl = json['prev_page_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['next_page_url'] = this.nextPageUrl;
    data['prev_page_url'] = this.prevPageUrl;
    return data;
  }
}

class Data {
  String? header1;
  String? header2;
  String? tipe;
  String? properties;
  String? createDate;

  Data({this.header1, this.header2, this.tipe, this.properties, this.createDate});

  Data.fromJson(Map<String, dynamic> json) {
    header1 = json['header1'];
    header2 = json['header2'];
    tipe = json['tipe'];
    properties = json['properties'];
    createDate = json['create_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['header1'] = this.header1;
    data['header2'] = this.header2;
    data['tipe'] = this.tipe;
    data['properties'] = this.properties;
    data['create_date'] = this.createDate;
    return data;
  }
}
