import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionController extends GetxController 
{
  final String _categorykey='categorytitle';
  
  //Admin Dashboard
  TextEditingController categoryTitleController=TextEditingController();
  TextEditingController QuestionControllerText=TextEditingController();
  final List<TextEditingController> optioncontrollers=List.generate(4,((index) => TextEditingController()));
  final TextEditingController CorrectAnswerController=TextEditingController();

  RxList<String> SavedCategories=<String>[].obs;


  void saveQuestionCategorytosharedpreferences() async
  {
    final prefs= await SharedPreferences.getInstance();
    SavedCategories.add(categoryTitleController.text);
    print(categoryTitleController.text);
    await prefs.setStringList(_categorykey,SavedCategories);

    categoryTitleController.clear();
    Get.snackbar('Saved', 'Category created successfuly');
    update();
  }
  void loadQuestionCategoryfromsharedpreferences() async
  {
    final prefs= await SharedPreferences.getInstance();
    final categories= prefs.getStringList(_categorykey) ?? [];

    SavedCategories.assignAll(categories);
    update();
  }
}