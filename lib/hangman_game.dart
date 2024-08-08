import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hangman Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HangmanGame(),
    );
  }
}

class HangmanGame extends StatefulWidget {
  @override
  _HangmanGameState createState() => _HangmanGameState();
}

class _HangmanGameState extends State<HangmanGame> {
  final _words = [
    'hello',
    'world',
    'flutter',
    'hangman',
    'game',
    'reflect',
    'happy',
    // Add more words here
  ];
  late String _word;
  Set<String> _guessedLetters = {};
  int _wrongGuesses = 0;
  bool _gameOver = false;
  bool _won = false;
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _startNewGame();
  }

  void _startNewGame() {
    final random = Random();
    setState(() {
      _word = _words[random.nextInt(_words.length)];
      _guessedLetters.clear();
      _wrongGuesses = 0;
      _gameOver = false;
      _won = false;
    });
  }

  void _makeGuess(String letter) {
    if (_gameOver) return;

    if (letter.length != 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a single letter')),
      );
      return;
    }

    if (_guessedLetters.contains(letter)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You already guessed $letter')),
      );
      return;
    }

    setState(() {
      _guessedLetters.add(letter);

      if (_word.contains(letter)) {
        if (_word.split('').every((char) => _guessedLetters.contains(char))) {
          _won = true;
          _gameOver = true;
          _score += 10; // Increase score
        }
      } else {
        _wrongGuesses++;
        if (_wrongGuesses == 6) {
          _gameOver = true;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hangman Game'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: const Color.fromARGB(255, 0, 0, 0)),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg.png', // Path to your background image
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: _buildWordBox(),
              ),
              SizedBox(height: 20),
              Text(
                'Wrong guesses left: ${6 - _wrongGuesses}',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              SizedBox(height: 20),
              Text(
                'Guessed letters: ${_guessedLetters.join(', ')}',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              SizedBox(height: 20),
              if (_gameOver)
                Column(
                  children: [
                    Text(
                      _won ? 'You WON!' : 'You LOST!',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 0, 0, 0)),
                    ),
                    SizedBox(height: 20),
                   
                  ],
                ),
              SizedBox(height: 20),
              CustomKeyboard(
                onKeyPressed: _makeGuess,
                onNext: _won
                    ? () {
                        if (_won) {
                          _startNewGame();
                        }
                      }
                    : null,
                onPlayAgain: () {
                  _score = 0;
                  _startNewGame();
                },
                isNextEnabled: _won,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWordBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _word.split('').map((letter) {
        return Container(
          width: 40,
          height: 40,
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          child: Center(
            child: Text(
              _guessedLetters.contains(letter) ? letter : '_',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class CustomKeyboard extends StatelessWidget {
  final Function(String) onKeyPressed;
  final VoidCallback? onNext;
  final VoidCallback onPlayAgain;
  final bool isNextEnabled;

  CustomKeyboard({
    required this.onKeyPressed,
    this.onNext,
    required this.onPlayAgain,
    this.isNextEnabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: GridView.count(
        crossAxisCount: 6,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          ...'QWERTYUIOPASDFGHJKLZXCVBNM'.split('').map((e) {
            return GestureDetector(
              onTap: () {
                onKeyPressed(e.toLowerCase());
              },
              child: Container(
                margin: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color.fromARGB(255, 227, 208, 30), Color.fromARGB(255, 255, 245, 111)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: Offset(2, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    e,
                    style: TextStyle(
                      fontSize: 26,
                      color: Color.fromARGB(255, 39, 38, 38),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
          if (isNextEnabled)
            _buildControlButton('Next', onNext, Colors.transparent, isNextEnabled, false),
          _buildControlButton('Play Again', onPlayAgain, Colors.transparent, true, false),
        ],
      ),
    );
  }

  Widget _buildControlButton(
      String label, VoidCallback? onPressed, Color color, bool isEnabled, bool isLarge) {
    return GestureDetector(
      onTap: isEnabled ? onPressed : null,
      child: Container(
        margin: EdgeInsets.all(4),
        width: isLarge ? 150 : 80,
        height: isLarge ? 60 : 40,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orangeAccent, Colors.deepOrangeAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: Offset(2, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: isLarge ? 24 : 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
