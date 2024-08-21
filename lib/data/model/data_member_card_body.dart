import 'package:json_annotation/json_annotation.dart';

part 'data_member_card_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DataMemberCardBody {
  String? idUser;

  DataMemberCardBody({this.idUser});

  DataMemberCardBody.fromJson(Map<String, dynamic> json) {
    idUser = json['id_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_user'] = this.idUser;
    return data;
  }
}
