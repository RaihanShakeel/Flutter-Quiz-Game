import 'package:flutter/material.dart';
import 'package:frivia/providers/game_page_provider.dart';
import 'package:provider/provider.dart';

class GamePage extends StatelessWidget{
  String level;
  GamePage({super.key, required this.level});

  double? _screenHeight, _screenWidth;
  GamePageProvider? _pageProvider;

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) => GamePageProvider(context: context, difficultyLevel: level),
      child:_uiBuild(),
    );
  }

  Widget _uiBuild(){
    return Builder(
      builder: (context) {
        _pageProvider = context.watch<GamePageProvider>();
        if (_pageProvider!.questions != null){
          return Scaffold(
            body: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: _screenWidth! * 0.05,
                ),
                child: _gameUI(),
              ),
            ),
          );
        }else{
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }
      }
    );
  }

  Widget _gameUI(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _questionText(),
        Column(
          children: [
            _trueButton(),
            SizedBox(height: _screenHeight! * 0.01,),
            _falseButton(),
          ],
        )
      ],
    );
  }

  Widget _questionText(){
    return Text(
      _pageProvider!.getCurrentQuestion(),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.w400
      ),
    );
  }

  Widget _trueButton(){
    return MaterialButton(
      onPressed: () {
        _pageProvider?.answerQuestion("True");
      },
      color: Colors.green,
      minWidth: _screenWidth! * 0.8,
      height: _screenHeight! * 0.08,
      child: const Text(
        "True",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w400,
        ),
      ),

    );
  }

  Widget _falseButton(){
    return MaterialButton(
      onPressed: () {
        _pageProvider?.answerQuestion("False");
      },
      color: Colors.red,
      minWidth: _screenWidth! * 0.8,
      height: _screenHeight! * 0.08,
      child: const Text(
        "False",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w400,
        ),
      ),

    );
  }
}