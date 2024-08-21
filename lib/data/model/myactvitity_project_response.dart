import 'package:json_annotation/json_annotation.dart';

part 'myactivity_project_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GetProjectResponse {
  int? status;
  String? message;
  List<Data>? data;

  GetProjectResponse({this.status, this.message, this.data});

  GetProjectResponse.fromJson(Map<String, dynamic> json) {
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

@JsonSerializable(fieldRename: FieldRename.snake)
class Data {
  String? projectId;
  String? projectDesc;
  String? projectStatus;

  Data({this.projectId, this.projectDesc, this.projectStatus});

  Data.fromJson(Map<String, dynamic> json) {
    projectId = json['project_id'];
    projectDesc = json['project_desc'];
    projectStatus = json['project_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['project_id'] = this.projectId;
    data['project_desc'] = this.projectDesc;
    data['project_status'] = this.projectStatus;
    return data;
  }
}
