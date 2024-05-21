import 'package:flutter/material.dart';
import "../constraints.dart";

class ResultBox extends StatelessWidget {
  const ResultBox({super.key,
  required this.result,
  required this.questionLength,
  required this.onPressed,
  });

  final int result;
  final int questionLength;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: bg,
      content: Padding(
        padding: const EdgeInsets.all(60.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Result',
              style: TextStyle(color: neutral,fontSize:30.0),
          ),
          const SizedBox(height: 20.0,),
          CircleAvatar(
            radius: 70.0,
            backgroundColor: 
            result==questionLength? 
            correct:result>questionLength/3&&result<questionLength/2 ?
            Colors.yellow:incorrect,
            child: Text('$result/$questionLength',style: const TextStyle(fontSize: 30.0),)
          ),
          const SizedBox(height: 20.0),
          Text(result==questionLength? 
            'Great!':
            result>questionLength/3&&result<questionLength/2 ?
            'Almost There':
            'Try Again?'
            ,style: const TextStyle(color: neutral ),
            ),
            const SizedBox(height: 25.0),
            GestureDetector(
              onTap: onPressed,
              child: const Text('Start Over',style: TextStyle(color:correct,fontSize: 20.0,letterSpacing: 1.0),),
            )
        ],
       )
      )
      );
  }
}
