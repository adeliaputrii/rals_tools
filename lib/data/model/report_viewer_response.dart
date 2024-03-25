import 'package:json_annotation/json_annotation.dart';

part 'report_viewer_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ReportViewerResponse {
  int? status;
  String? message;
  List<Data>? data;

  ReportViewerResponse({this.status, this.message, this.data});

  ReportViewerResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? idReport;
  int? viewer;

  Data({this.idReport, this.viewer});

  Data.fromJson(Map<String, dynamic> json) {
    idReport = json['id_report'];
    viewer = json['viewer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_report'] = this.idReport;
    data['viewer'] = this.viewer;
    return data;
  }
}
