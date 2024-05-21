
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constraints.dart';
import 'question_controller.dart';
import '../model/question_model.dart';
import '../model/db_connect.dart';

class AdminScreen extends StatelessWidget
{
  final String QuizCategory;
  AdminScreen({super.key,required this.QuizCategory});
  final QuestionController questionController=Get.find();

  @override
  Widget build(BuildContext context)
  {
    Map<String, bool> convertToMap(List<TextEditingController> controllers)
    {
      Map<String, bool> options = {};
      for (var controller in controllers) {
        String key = controller.text;
        options[key] = false;
      }
      options[questionController.optioncontrollers[int.parse(questionController.CorrectAnswerController.text)-1].text]=true;
      return options;
    }
    void addQuestion()
    {
      final String QuestionText=questionController.QuestionControllerText.text;
      final List<String> options=questionController.optioncontrollers.map((controller) => controller.text).toList();
      final Map<String, bool> Options = convertToMap(questionController.optioncontrollers);
      DBconnect().addQuestion(Question(id: '1' ,title: QuestionText, options: Options),QuizCategory);
      Get.snackbar("Added", "Question Added");
      questionController.QuestionControllerText.clear();
      questionController.optioncontrollers.forEach((element) {
        element.clear();
      });
      questionController.CorrectAnswerController.clear();
    }


    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Add Question to $QuizCategory',style: const TextStyle(color: Colors.white),),
        backgroundColor: correct,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                controller: questionController.QuestionControllerText,
                style: TextStyle(color: neutral),
                decoration: const InputDecoration(labelText: 'Question',labelStyle: TextStyle(color: Colors.white,fontSize: 25)),
              ),
              for(var i=0;i<4;i++)
                TextFormField(
                  controller: questionController.optioncontrollers[i],
                  style: TextStyle(color: neutral),
                  decoration: InputDecoration(labelText: 'Option ${i+1}',labelStyle: const TextStyle(color: Colors.white)),
                ),
              TextFormField(
                controller: questionController.CorrectAnswerController,
                style: TextStyle(color: neutral),
                decoration: const InputDecoration(labelText: 'Correct Answer (1-4)',labelStyle: TextStyle(color: Colors.white),
              ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(onPressed: (){
                if(questionController.QuestionControllerText.text.isEmpty)
                {
                  Get.snackbar("Required", "Please add Question");
                }
                else if(questionController.optioncontrollers[0].text.isEmpty)
                {
                  Get.snackbar("Required", "Please add Option");
                }
                else if(questionController.optioncontrollers[1].text.isEmpty)
                {
                  Get.snackbar("Required", "Please add Option");
                }
                else if(questionController.optioncontrollers[2].text.isEmpty)
                {
                  Get.snackbar("Required", "Please add Option");
                }
                else if(questionController.optioncontrollers[3].text.isEmpty)
                {
                  Get.snackbar("Required", "Please add Option");
                }
                else if(questionController.CorrectAnswerController.text.isEmpty)
                {
                  Get.snackbar("Required", "Please add the correctAnswer");
                }
                else
                {
                  addQuestion();
                }
              },style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(correct)), child: const Text('Add Question',style: TextStyle(color: Colors.white)),),
            ],
            ),
        ),
      ),
    );
  }
}