// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.blue,
          appBar: AppBar(
            title: Center(
              child: Text(
                'Dice Dash',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 36.0,
                ),
              ),
            ),
            backgroundColor: Colors.blue,
          ),
          body: DicePage(),
        ),
      ),
    ),
  );
}

class DicePage extends StatefulWidget {
  const DicePage({Key? key}) : super(key: key);

  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int leftDiceNumber = 1;
  int rightDiceNumber = 1;
  int scorePlayer1 = 0;
  int scorePlayer2 = 0;
  String player1Name = "Player 1";

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _askPlayerName();
    });
  }

  void _askPlayerName() {
    TextEditingController nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enter your name"),
          content: TextField(
            controller: nameController,
            decoration: InputDecoration(hintText: "Player 1 Name"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                setState(() {
                  player1Name = nameController.text.isNotEmpty
                      ? nameController.text
                      : "Player 1";
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _diceFaceChange() {
    setState(() {
      leftDiceNumber = Random().nextInt(6) + 1;
      rightDiceNumber = Random().nextInt(6) + 1;

      scorePlayer1 += leftDiceNumber;
      scorePlayer2 += rightDiceNumber;

      if (scorePlayer1 >= 100) {
        showWinnerDialog(player1Name);
        resetScores();
      } else if (scorePlayer2 >= 100) {
        showWinnerDialog("Computer");
        resetScores();
      }
    });
  }

  void resetScores() {
    scorePlayer1 = 0;
    scorePlayer2 = 0;
  }

  void showWinnerDialog(String winner) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Congratulations!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Pacifico',
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "$winner has won with 100 points!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 24.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Icon(
                Icons.emoji_events,
                color: Colors.amber,
                size: 50,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "OK",
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 20.0,
                  color: Colors.blue,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 0),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    player1Name,
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 28.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    "VS",
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 24.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    "Computer",
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 28.0,
                      color: Color.fromARGB(255, 22, 1, 29),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: _diceFaceChange,
                      child: Image.asset('images/dice$leftDiceNumber.png'),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: _diceFaceChange,
                      child: Image.asset('images/dice$rightDiceNumber.png'),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "Score: $scorePlayer1",
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 28.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    "Score: $scorePlayer2",
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 28.0,
                      color: Color.fromARGB(255, 22, 1, 29),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
