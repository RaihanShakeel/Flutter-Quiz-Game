import 'package:flutter/material.dart';
import 'package:frivia/pages/game_page.dart';

class MainPage extends StatefulWidget{
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<String> difficultyLevels = ['Easy', 'Medium', 'Hard'];
  double sliderValue = 0;
  double? _screenHeight, _screenWidth;
  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  mainTitle(),
                  const SizedBox(height: 10.0,),
                  difficultyText(),
                ],
              ),
            ),
            difficultySlider(),
            startButton()
          ],
        ),
      ),
    );
  }

  Widget mainTitle(){
    return const Text(
      "Frivia",
      style: TextStyle(
        color: Colors.white,
        fontSize: 32,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget difficultyText(){
    return Text(
      difficultyLevels[sliderValue.toInt()],
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget difficultySlider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _screenWidth! * 0.2),
      child: Slider(
        min: 0,
        max: (difficultyLevels.length-1).toDouble(),
        value: sliderValue,
        divisions: difficultyLevels.length-1,
        thumbColor: Colors.blue,
        activeColor: Colors.blue,
        inactiveColor: const Color.fromARGB(255, 30, 63, 91),
        onChanged: (value) {
          setState(() {
            sliderValue = value;
          });
        },
      ),
    );
  }

  Widget startButton(){
    return MaterialButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GamePage(level: difficultyLevels[sliderValue.toInt()].toLowerCase(),),
          )
        );
      },
      color: Colors.blue,
      minWidth: _screenWidth! * 0.5,
      height: _screenHeight! * 0.08,
      child: const Text(
        'Start',
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w500
        ),
      ),
    );
  }
}