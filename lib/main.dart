import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:quizz/QuestionBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Questionbrain questionbrain = new Questionbrain();
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Quizzler",
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10), child: Quizz()),
        ),
      ),
    );
  }
}

class Quizz extends StatefulWidget {
  @override
  _QuizzState createState() => _QuizzState();
}

class _QuizzState extends State<Quizz> {
  List<Icon> shopkeeper = [];
  int score = 0;
  void endquizz()
  {
       Alert(
            context: context,
            type: AlertType.success,
            title: "Quizz Completed",
            desc: "Thank You. you got $score/13 score on This Quiz.",
            buttons: [
              DialogButton(
                child: Text(
                  "COOL",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {},
                width: 120,
              )
            ],
          ).show();
          shopkeeper.removeRange(0,12);
          score=0;
  }
  Void checkAnswer(bool answer) {
    bool correctAnswer = questionbrain.getQuestionAnswer();
    setState(
      () {
          
        if (correctAnswer == answer) {
           if (questionbrain.endQuetion() == true) {
       endquizz();
          
        }
          shopkeeper.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
          print("U Got Right answer");
          score++;
        } else {
          Icon(
            Icons.close,
            color: Colors.red,
          );
          shopkeeper.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
          print("U got wrong answer");
        }

        questionbrain.nextQuestion();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questionbrain.getQuestionText(),
                style: TextStyle(fontSize: 30.0, color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.green,
              child: Text("true"),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text("false"),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: shopkeeper,
        )
      ],
    );
  }
}
