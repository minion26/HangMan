// import 'dart:math';
import 'package:flutter/material.dart';

class Keyboard extends StatefulWidget {
  final Function(String) onLetterPressed;
  final ValueNotifier<bool> resetNotifier;

  const Keyboard({required this.onLetterPressed, required this.resetNotifier});

  @override
  _KeyboardState createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {
  final List<String> _letters = 'AĂÂBCDEFGHIÎJKLMNOPQRSȘTȚUVWXYZ'.split('');
  final Map<String, Color> _letterColors = {};
  final Map<String, bool> _guessedLetters = {};
  String? _lastPressedLetter;

  @override
  void initState() {
    super.initState();
    widget.resetNotifier.addListener(reset);
  }

  @override
  void dispose() {
    widget.resetNotifier.removeListener(reset);
    super.dispose();
  }

  void reset() {
    if (widget.resetNotifier.value) {
      setState(() {
        _guessedLetters.clear();
        _letterColors.clear();
        _lastPressedLetter = null;
        print("[DEBUG] Resetting keyboard");
        print("[DEBUG] Guessed letters: $_guessedLetters");
        print("[DEBUG] Letter colors: $_letterColors");
        print("[DEBUG] Last pressed letter: $_lastPressedLetter");
      });
      widget.resetNotifier.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Wrap(
        spacing: 10, // gap between adjacent chips
        runSpacing: 10, // gap between lines
        children: _letters.map((String letter) {
          return Container(
            width: 60, // set width
            height: 60, // set height
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    _letterColors[letter] ??
                        Color.fromARGB(255, 215, 136, 228)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              onPressed: _guessedLetters[letter] == true
                  ? null
                  : () {
                      final isCorrect = widget.onLetterPressed(letter);
                      setState(() {
                        _guessedLetters[letter] = true;
                        _letterColors[letter] =
                            isCorrect ? Colors.green : Colors.grey;
                        _lastPressedLetter = letter;
                        print('[DEBUG] Pressed letter: $_lastPressedLetter');
                      });
                    },
              child: Text(
                letter,
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
