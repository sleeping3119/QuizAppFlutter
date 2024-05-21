import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz/constraints.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({super.key,required this.title,required this.index, required this.total});

  final String title;
  final int index;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Text(" Question ${index +1}/${total+1}:",
          style:const TextStyle(color: Colors.yellowAccent,
          fontSize: 18,
          ),
          ),
          Text(" $title",
          style:const TextStyle(color: neutral,
          fontSize: 18,
          ),
          ),
        ],
      ),
    );
  }
}
