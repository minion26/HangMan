import 'dart:math';
import 'package:flutter/material.dart';
import 'keyboard.dart';
import 'database.dart';
import 'main.dart';

class PlayGame extends StatefulWidget {
  @override
  _PlayGameState createState() => _PlayGameState();
}

class _PlayGameState extends State<PlayGame> {
  // final List<String> words = [
  //   'casă',
  //   'carte',
  //   'minge',
  //   'pădure',
  //   'bibliotecă',
  //   'calculator',
  //   'universitate',
  //   'responsabilitate',
  //   'bucurești',
  //   'constituționalitate'
  // ];

  List<String> words = [
    "casa",
    "este",
    "mare",
    "ziua",
    "noapte",
    "timp",
    "bine",
    "cinci",
    "doar",
    "amici",
    "cafea",
    "linie",
    "oameni",
    "pădure",
    "poezie",
    "soare",
    "verde",
    "vreme",
    "zid",
    "albastru",
    "aceasta",
    "acele",
    "acești",
    "altele",
    "anotimp",
    "aventură",
    "bătrân",
    "călător",
    "cerere",
    "copil",
    "durere",
    "dureri",
    "familie",
    "gesturi",
    "insula",
    "jucător",
    "medalie",
    "melodie",
    "metaforă",
    "minunat",
    "nascut",
    "parte",
    "patru",
    "plăcere",
    "plimbare",
    "povești",
    "prieteni",
    "proces",
    "proiect",
    "proprietate",
    "scenariu",
    "simplu",
    "succes",
    "subsol",
    "timp",
    "viteză",
    "adevăr",
    "analiză",
    "apariție",
    "băiat",
    "caracter",
    "căutare",
    "copilărie",
    "curaj",
    "destin",
    "disponibil",
    "diversitate",
    "domeniu",
    "educație",
    "evoluție",
    "fascinație",
    "fericit",
    "florărie",
    "funcționar",
    "imaginație",
    "împăcare",
    "întrebare",
    "operație",
    "răbdare",
    "rugaciune",
    "tabara",
    "gluma",
    "mică",
    "fericit",
    "măreţie",
    "lacrimă",
    "fereastră",
    "grădina",
    "grădini",
    "mic-dejun",
    "nevastă",
    "răsărit",
    "săptămână",
    "sculptură",
    "sentiment",
    "serenită",
    "soarele",
    "umilinţă",
    "zăpadă",
    "analiză",
    "apariţie",
    "asigurare",
    "băiat",
    "căutare",
    "copilărie",
    "educaţie",
    "evoluţie",
    "generozitate",
    "imagine",
    "împăcare",
    "întrebare",
    "operaţie",
    "responsabilitate",
    "satisfacţie"
  ];

  String currentWord = '';
  String hiddenWord = '';
  int tryes = 0; // The number of parts of the stick man the player has
  int lives = 3; // The number of lives the player has
  int score = 0;
  int wordScore = 0;

  final List<String> images = [
    'assets/game/0.png',
    'assets/game/1.png',
    'assets/game/2.png',
    'assets/game/3.png',
    'assets/game/4.png',
    'assets/game/5.png',
    'assets/game/6.png',
  ];

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    // words.shuffle(Random());
    // print('Shuffled words: $words');
    Random random = new Random();
    int randomNumber = random.nextInt(words.length);
    currentWord = words[randomNumber];
    wordScore = randomNumber;
    // currentWord = words.first;
    hiddenWord = List.filled(currentWord.length, '_').join();
    tryes = 0;
    setState(() {
      lives = 3; // Reset the number of lives when a new game starts
    });
  }

  bool guessLetter(String letter) {
    if (currentWord.contains(letter)) {
      // revealLetter(letter);
      return true;
    } else {
      setState(() {
        tryes++;
      });
    }
    checkGameOver();
    return false;
  }

  void revealLetter(String letter) {
    print("[DEBUG] Revealing letter: $letter");
    setState(() {
      hiddenWord = String.fromCharCodes(
        List.generate(currentWord.length, (index) {
          return currentWord[index] == letter
              ? letter.codeUnitAt(0)
              : hiddenWord.codeUnitAt(index);
        }),
      );
    });
    asteapta();
  }

  void asteapta() async {
    // await Future.delayed(Duration(seconds: 1));
    checkGameOver();
  }

  Future<void> checkGameOver() async {
    if (hiddenWord == currentWord) {
      // The player has won
      print("You've won!");
      score += wordScore;
      // You can add more code here to handle the win condition
      showDialog(
        context: context,
        barrierDismissible:
            false, // Prevent dialog from closing on outside click
        builder: (context) {
          return AlertDialog(
            // title: Text('Congratulations!'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.check,
                  color: Colors.green,
                  size:
                      30.0, // Ajustează această valoare pentru a face iconița mai mică sau mai mare
                ),
                Text('The correct word was $currentWord'),
              ],
            ),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  startNewGame();
                },
              ),
            ],
          );
        },
      );
    } else if (tryes == 7) {
      // The player has lost
      print("You've lost!");
      lives -= 1;
      showDialog(
        context: context,
        barrierDismissible:
            false, // Prevent dialog from closing on outside click
        builder: (context) {
          return AlertDialog(
            title: Text('Oops!'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.close,
                  color: Colors.red,
                  size:
                      30.0, // Ajustează această valoare pentru a face iconița mai mică sau mai mare
                ),
                Text('The word was $currentWord'),
              ],
            ),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  startNewGame();
                },
              ),
            ],
          );
        },
      );
    }

    if (lives == 0) {
      // i will write to the database file
      var date = new DateTime.now();
      Database db = Database();
      db.writeScore(date, score);

      showDialog(
        context: context,
        barrierDismissible:
            false, // Prevent dialog from closing on outside click
        builder: (context) {
          return AlertDialog(
            title: Text('Game Over'),
            content: Text('You have no more lives. Want to play again?'),
            actions: [
              TextButton(
                child: Text('Yes'),
                onPressed: () {
                  Navigator.of(context).pop();
                  startNewGameWithoutLives();
                },
              ),
              TextButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            HomeScreen()), // replace MainPage with your main page widget
                  );
                },
              ),
            ],
          );
        },
      );
    }
  }

  void startNewGame() {
    setState(() {
      // Set currentWord to a new word
      currentWord =
          getNewWord(); // Replace getNewWord with your own function to get a new word

      // Reset hiddenWord
      hiddenWord = List.filled(currentWord.length, '_').join();

      tryes = 0;

      resetNotifier.value = true;
    });
  }

  void startNewGameWithoutLives() {
    setState(() {
      // Set currentWord to a new word
      currentWord =
          getNewWord(); // Replace getNewWord with your own function to get a new word

      // Reset hiddenWord
      hiddenWord = List.filled(currentWord.length, '_').join();

      // Reset lives
      tryes = 0;

      lives = 3;

      score = 0;

      resetNotifier.value = true;
    });
  }

  String getNewWord() {
    Random random = new Random();
    int randomNumber = random.nextInt(words.length);
    currentWord = words[randomNumber];
    wordScore = randomNumber * 10;
    return currentWord;
  }

  final resetNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(207, 207, 196, 1.0),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(207, 207, 196, 1.0),
        title: Text('Hangman Game',
            style: TextStyle(
              fontFamily: 'AmaticSC',
              fontSize: 35.0,
            )),
        actions: <Widget>[
          Row(
            children: <Widget>[
              Text(
                '$lives', // Display the number of lives
                style: TextStyle(
                    fontFamily: "Pacifico-Regular",
                    fontSize: 24,
                    color: Colors.red),
              ),
              Icon(
                Icons.favorite,
                color: Colors.red,
                size:
                    40.0, // Adjust this value to make the heart smaller or larger
              ),
              SizedBox(width: 10),
              Text(
                'Score: $score', // Display the current score
                style: TextStyle(
                    fontFamily: "AmaticSC", fontSize: 24, color: Colors.black),
              ),
              SizedBox(width: 30),
            ],
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Guess the word:',
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'AmaticSC',
              fontWeight: FontWeight.bold,
            ),
          ),
          Image.asset(
            tryes < 7 ? images[tryes] : images[6],
            width: 200,
            height: 200,
          ),
          Text(
            hiddenWord,
            style: TextStyle(
              fontSize: 40,
              fontFamily: 'AmaticSC',
              fontWeight: FontWeight.bold,
            ),
          ),
          // Text(
          //   'Tryes: $tryes / 7',
          //   style: TextStyle(fontSize: 24),
          // ),
          Keyboard(
            onLetterPressed: (String letter) {
              print("[DEBUG] correct word: $currentWord");
              String guessedLetter = letter.toLowerCase();
              final isCorrect = guessLetter(guessedLetter);
              if (isCorrect == true) {
                print("[DEBUG] Correct letter: $guessedLetter");
                revealLetter(guessedLetter);
              } else {
                print("[DEBUG] Incorrect letter: $letter");
              }
              return isCorrect;
            },
            resetNotifier: resetNotifier,
          ),
        ],
      ),
    );
  }
}
