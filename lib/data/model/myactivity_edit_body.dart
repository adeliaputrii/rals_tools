import 'package:json_annotation/json_annotation.dart';

part 'myactivity_edit_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MyActivityEditBody {
     String? userCreate;
     

    MyActivityEditBody({
          this.userCreate,
          
    });

     MyActivityEditBody.fromJson(Map<String, dynamic> json) {
        userCreate: json["user_create"];
        
  }

   Map<String, dynamic> toJson() {
     Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_create'] = this.userCreate;
    
    return data;
  }

}