import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'hangman_game.dart'; // Your main game logic
import 'how_to_play.dart'; // Implement this screen
import 'load_game.dart'; // Implement this screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'GameFont'
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/newGame': (context) => HangmanGame(),
        '/loadGame': (context) => LoadGameScreen(),
        '/howToPlay': (context) => HowToPlayScreen(),
      },
    );
  }
}
