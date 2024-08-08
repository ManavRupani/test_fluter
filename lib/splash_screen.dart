import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/hman.jpg', // Path to your background image
              fit: BoxFit.cover, // Ensure the image covers the whole screen
            ),
          ),
          // Content on top of the background image
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hangman Game',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 102, 0), // Ensure text is readable on the image
                  ),
                ),
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/newGame');
                  },
                  child: Text(
                    'Start a New Game',
                    style: TextStyle(color: Colors.white), // Text color for the button
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // Button background color
                    minimumSize: Size(200, 50),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/loadGame');
                  },
                  child: Text(
                    'Load from Save',
                    style: TextStyle(color: Colors.white), // Text color for the button
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // Button background color
                    minimumSize: Size(200, 50),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/howToPlay');
                  },
                  child: Text(
                    'How to Play',
                    style: TextStyle(color: Colors.white), // Text color for the button
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // Button background color
                    minimumSize: Size(200, 50),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
