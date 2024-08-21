import 'package:flutter/cupertino.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';

class  HomeTaskTotal{
   HomeTaskTotal({
    required this.unread_task,
    required this.total_task,
  });
  final String unread_task,total_task;
   


  
    factory  HomeTaskTotal.fromjson(Map<String, dynamic> json1,) =>  HomeTaskTotal(
    unread_task: json1["unread_task"],
    total_task: json1["total_task"],
    );
    
  static List< HomeTaskTotal> hometasktotal = [];
}