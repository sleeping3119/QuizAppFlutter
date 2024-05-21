import 'package:flutter/material.dart';
import 'package:quiz/admin/Admin_dashboard.dart';
import 'package:quiz/model/db_connect.dart';
import 'package:quiz/model/question_model.dart';
import 'package:quiz/widget/category.dart';
import "screen/home_screen.dart";
import './admin/Admin_screen.dart';
import 'package:get/get.dart';

main(){
  runApp(const myApp());
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


