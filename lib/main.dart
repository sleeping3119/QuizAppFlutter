import 'package:flutter/material.dart';
import 'package:quiz/admin/Admin_dashboard.dart';
import 'package:quiz/model/db_connect.dart';
import 'package:quiz/model/question_model.dart';
import 'package:quiz/widget/category.dart';
import "./screen/screens/home_screen.dart";
import './admin/Admin_screen.dart';
import 'package:get/get.dart';

main(){
  runApp(const myApp());
  // var db = DBconnect();
  // db.addQuestion(Question(id: "1", title: "bye", options: {
  //   "optionq":true, "option2":false, "option3": false, "option4":false
  // }
  // ));
}


// ignore: camel_case_types
class myApp extends StatelessWidget {
  
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:CategoryScreen(),
      //home: HomeScreen(),
      //home: Admin(),
    );
  }
}


