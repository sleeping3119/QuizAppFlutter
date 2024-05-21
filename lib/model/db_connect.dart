import 'package:http/http.dart' as http;
import 'question_model.dart';
import 'dart:convert';

class DBconnect
{
  final _link="https://simple-quiz-27a36-default-rtdb.asia-southeast1.firebasedatabase.app/";
  //final url=Uri.parse("https://simple-quiz-27a36-default-rtdb.asia-southeast1.firebasedatabase.app/math.json");
  //final _link="https://quizapp-19185-default-rtdb.firebaseio.com/";

  Future<void> addQuestion(Question question,String tablename) async
  {
    final url=Uri.parse('$_link$tablename.json');
    http.post(url,body: json.encode(
      { 
        'title': question.title,
        'options': question.options,
      }
    ),
    );
  }

  // Future<void> addQuestion(Question question) async
  // {
  //   http.post(url,body: json.encode(
  //     { 
  //       'title': question.title,
  //       'options': question.options,
  //     }
  //   ),
  //   );
  // }


   Future<List<Question>> fetchQuestions(String category) async
   {
    final url=Uri.parse('$_link$category.json');
    
    return http.get(url).then((response){
      var data=json.decode(response.body) as Map<String,dynamic>;
      List<Question> newQuestions=[];
      if (data != null && data is Map<String, dynamic>)
      {
        data .forEach((key,value){
          if (value != '' && value.toString()!='' && value.containsKey('options')&&value['title'].toString()!='')
          {
            var newQuestion=Question(
            id: key,
            title: value['title'],
            options: Map.castFrom(value['options'])
          );
          newQuestions.add(newQuestion);
          }
        }
        );
      }
        return newQuestions;
      });
  }


Future<void> deleteCategory(String Category) async {
      final url=Uri.parse('$_link$Category.json');
      http.delete(url);
  }



//   Future<List<Question>> fetchQuestions() async
//    {

//     return http.get(url).then((response){
//       var data=json.decode(response.body) as Map<String,dynamic>;
//       List<Question> newQuestions=[];
//       data .forEach((key,value){
//         var newQuestion=Question(
//           id: key,
//           title: value['title'],
//           options: Map.castFrom(value['options'])
//         );
//         newQuestions.add(newQuestion);
//       });
//       return newQuestions;
//     });
//    }


}