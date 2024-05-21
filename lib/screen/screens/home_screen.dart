import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz/constraints.dart';
import 'package:quiz/model/question_model.dart';
import 'package:quiz/model/db_connect.dart';
import 'package:quiz/widget/question_widget.dart';
import 'package:quiz/widget/result_box.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key,required this.category});
  final String category;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var db = DBconnect();
  late Future _questions;
  Future<List<Question>> getData() async {
    return db.fetchQuestions(widget.category);
  }

  @override
  void initState() {
    _questions = getData();
    super.initState();
  }

  //intialization
  int index = 0;
  int score = 0;
  bool click = false;
  bool alreadyClick = false;

  void scoreUpdater(bool correct) {
    if (!alreadyClick) {
      if (correct) {
        score++;
      }
      setState(() {
        click = true;
        alreadyClick = true;
      });
    }
  }

  void incremntIndex(int length) {
    if (click && index >= length - 1) {
      showDialog(
          context: context,
          builder: ((ctx) => ResultBox(
              questionLength: length,
              onPressed: startOver,
              result: score)));
    } else {
      setState(() {
        if (click == true) {
          click = false;
          alreadyClick = false;
          index++;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please select any option'),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.fromLTRB(9, 0, 9, 64),
            ),
          );
        }
      });
    }
  }

  void startOver() {
    setState(() {
      index = 0;
      score = 0;
      click = false;
      alreadyClick = false;
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _questions as Future<List<Question>>,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error occurred: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            var extractedData = snapshot.data as List<Question>;
            // Handle your extracted data here
            return Scaffold(
              backgroundColor: bg,
              appBar: AppBar(
                title: const Text("Quiz App",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    )),
                 iconTheme: const IconThemeData(
                 color: neutral, // Change this to the desired color
                 ),
                elevation: 0,
                backgroundColor: bg,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Text(
                      "Score: $score",
                      style: const TextStyle(
                        fontSize: 19,
                        color: neutral,
                      ),
                    ),
                  )
                ],
              ),
              body: Container(
                padding: const EdgeInsets.only(top: 20),
                width: double.infinity,
                child: Column(
                  children: [
                    QuestionWidget(
                      index: index,
                      total: 1,
                      title: extractedData[index].title,
                    ),
                    const SizedBox(height: 25),
                    ...extractedData[index]
                        .options
                        .keys
                        .map((option) => GestureDetector(
                              onTap: () => scoreUpdater(
                                  (extractedData[index].options[option] == true
                                      ? true
                                      : false)),
                              child: OptionsWidget(
                                option: option,
                                color: click == true
                                    ? (extractedData[index].options[option] ==
                                            true
                                        ? correct
                                        : incorrect)
                                    : neutral,
                              ),
                            )),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed:() => incremntIndex(extractedData.length),
                            style: const ButtonStyle(
                              foregroundColor:
                                  MaterialStatePropertyAll(Color(0xFF121212)),
                              shape: MaterialStatePropertyAll(
                                  ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)))),
                              backgroundColor:
                                  MaterialStatePropertyAll(correct),
                            ),
                            child: const Text("Next")),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }
        return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green[300]!),
              ),
        );
      },
    );
  }
}


class OptionsWidget extends StatelessWidget {
  const OptionsWidget({
    super.key,
    required this.option,
    required this.color,
  });
  final Color color;
  final String option;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: ListTile(
        title: Text(
          option,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
