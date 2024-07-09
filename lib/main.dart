import 'package:flutter/material.dart';
import 'package:hangman/play_game.dart';
import 'package:hangman/high_scores.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game App',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(207, 207, 196, 1.0),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(207, 207, 196, 1.0),
        title: Center(
          child: Text(
            'Hangman Game',
            style: TextStyle(
              fontFamily: 'AmaticSC',
              fontSize: 60.0,
            ),
          ),
        ),
      ),
      body: Center(
        // padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 40),
            Image.asset('assets/image.png'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to game screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlayGame()),
                );
              },
              child: Text('Play Game'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to high scores
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HighScores()),
                );
              },
              child: Text('High Scores'),
            ),
          ],
        ),
      ),
    );
  }
}
