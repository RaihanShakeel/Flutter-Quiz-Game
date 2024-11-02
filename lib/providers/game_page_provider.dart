import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';


class GamePageProvider extends ChangeNotifier{
  final Dio _dio = Dio();
  List? questions;
  int _currentQuestionCount = 0;
  final int _maxQuestions = 10;
  int _correctQuestions = 0;
  String difficultyLevel;

  BuildContext context;
  GamePageProvider({required this.context, required this.difficultyLevel}){

    _dio.options.baseUrl = 'https://opentdb.com/api.php';
    _getQuestionsFromApi();
  }

  Future<void> _getQuestionsFromApi() async {
    var response = await _dio.get(
      '',
      queryParameters: {
        'amount': 10,
        'type': 'boolean',
        'difficulty': difficultyLevel,
      }
    );
    var data = jsonDecode(
      response.toString(),
    );
    questions = data['results'];
    notifyListeners();
  }

  String getCurrentQuestion(){
    return questions![_currentQuestionCount]['question'];
  }

  void answerQuestion(String ans) async {
    bool isCorrect = questions![_currentQuestionCount]['correct_answer'] == ans;
    _correctQuestions += isCorrect ? 1 : 0;
    _currentQuestionCount++;

    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          backgroundColor: isCorrect? Colors.green : Colors.red,
          icon: isCorrect? const Icon(Icons.check_box_rounded, color: Colors.white,)
          : const Icon(Icons.cancel_rounded, color: Colors.white,) 
        );
      }
    );
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pop(context);
    if (_currentQuestionCount == _maxQuestions){
      endGame();
    }
    else{
      notifyListeners();
    }
  }

  Future<void> endGame() async {
    showDialog(
      context: context,
      builder: (BuildContext context){
        return  AlertDialog(
          backgroundColor: Colors.blue,
          title:  const Text(
            "End Game!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25
            ),
          ),
          content: Text('Score: $_correctQuestions/$_maxQuestions'),
        );
      }
    );
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pop(context);
    Navigator.pop(context);

  }
}