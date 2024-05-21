import 'package:flutter/material.dart';
import "../model/db_connect.dart";
import '../admin/Admin_screen.dart';
import '../constraints.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import '../admin/question_controller.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});
  @override
  State<Admin> createState() => _Admin();
}

class _Admin extends State<Admin> 
{
  final QuestionController questioncontroller=Get.put(QuestionController());

  @override
  void initState()
  {
    questioncontroller.loadQuestionCategoryfromsharedpreferences();
    super.initState();
  }

  void showdialogbox()
    {
       showDialog(
      context: context,
      builder: (BuildContext context) {
      return AlertDialog(
        titlePadding: const EdgeInsets.all(15.0),
        contentPadding: const EdgeInsets.symmetric(horizontal: 25,vertical: 15),
        backgroundColor: Colors.black,
        title: const Text('Add Quiz',style: TextStyle(color: neutral),),
        content: Column(
          children: [
            TextFormField(
              controller: questioncontroller.categoryTitleController,
              style: TextStyle(color: neutral),
              decoration: const InputDecoration(hintText: "Enter the Category name",hintStyle: TextStyle(color: neutral)),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(correct),),
              child: const Text('Cancel',style: TextStyle(color: neutral),),
            ),
            ElevatedButton(
              onPressed: createcategory,
              style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(correct),),
              child: const Text('Create',style: TextStyle(color: neutral),)
            ),
        ],
        
      );
    }
       );
    }
  void createcategory()
  {
    // String Categorytitle=categoryTitleController.text;
    // print(Categorytitle);
    // final url=Uri.parse('https://quizapp-19185-default-rtdb.firebaseio.com/$Categorytitle.json');
    // http.post(url,body: json.encode({
      
    // }));
    // ScaffoldMessenger.of(context).showSnackBar(
    // SnackBar(content: Text('Category created successfully'))
    // );
    // Navigator.of(context).pop();
    questioncontroller.saveQuestionCategorytosharedpreferences();
    String S=questioncontroller.categoryTitleController.text;
    final url=Uri.parse('https://quizapp-19185-default-rtdb.firebaseio.com/$S.json');

    http.post(url,body: json.encode(
      { 
        'id':'',
        'title': '',
      }
    ),
    );
    Get.back();
  }
  void deleteCategory(String Category)
  {
    DBconnect().deleteCategory(Category);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: const Text('Admin DashBoard',style: TextStyle(color: neutral),
        textAlign: TextAlign.left,
        )
        ,backgroundColor: correct,
        shadowColor: Colors.transparent
      ),
      body: GetBuilder<QuestionController>(builder: (controller){
        return ListView.builder(
        itemCount: controller.SavedCategories.length,
        itemBuilder: (context,index) {
          return Card(
            child: ListTile(
              onTap:() {
                Get.to(
                  AdminScreen(QuizCategory: controller.SavedCategories[index])
                  );
              },
              leading: const Icon(Icons.question_answer),
              title: Text(controller.SavedCategories[index]),
              trailing: IconButton(
                onPressed:(){ 
                  deleteCategory(controller.SavedCategories[index]);
                  controller.SavedCategories.removeAt(index);
                  controller.update();
                },
                icon: const Icon(Icons.delete)
              ),
            ),
          );
        },
      );
      },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showdialogbox,
        child: const Icon(
          Icons.add
          ),
        ),
    );

}
}